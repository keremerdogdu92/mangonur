# Path: scripts/audio-tools.py
# Summary: Creates non-destructive voice derivatives using FFmpeg presets for gain, enhancement, denoise and best-effort room cleanup.
from __future__ import annotations

import argparse
import json
import shutil
import subprocess
from pathlib import Path


def require_binary(name: str) -> str:
    path = shutil.which(name)
    if not path:
        raise SystemExit(f"Required executable not found: {name}")
    return path


def build_filter(preset: str, gain_db: float) -> str:
    gain = f"volume={gain_db}dB"
    presets = {
        "voice-level": gain,
        "voice-enhance": f"{gain},highpass=f=70,lowpass=f=15500,acompressor=threshold=-18dB:ratio=2.2:attack=10:release=120,loudnorm=I=-16:LRA=7:TP=-1.5",
        "voice-clean": f"{gain},highpass=f=80,lowpass=f=14500,afftdn=nf=-25,acompressor=threshold=-20dB:ratio=2.4:attack=8:release=120,loudnorm=I=-16:LRA=7:TP=-1.5",
    }
    if preset not in presets:
        raise SystemExit(f"Unsupported FFmpeg preset: {preset}")
    return presets[preset]


def run_deepfilter(source: Path, destination: Path) -> bool:
    binary = shutil.which("deepFilter") or shutil.which("deep-filter")
    if not binary:
        return False
    workdir = destination.parent / ".deepfilter"
    workdir.mkdir(parents=True, exist_ok=True)
    subprocess.run([binary, str(source), "-o", str(workdir)], check=True)
    candidates = sorted(workdir.glob("*.wav"), key=lambda item: item.stat().st_mtime, reverse=True)
    if not candidates:
        return False
    shutil.move(str(candidates[0]), destination)
    return True


def main() -> None:
    parser = argparse.ArgumentParser()
    parser.add_argument("source", type=Path)
    parser.add_argument("destination", type=Path)
    parser.add_argument("--preset", choices=["voice-level", "voice-enhance", "voice-clean", "voice-clean-strong"], default="voice-clean")
    parser.add_argument("--gain-db", type=float, default=0.0)
    args = parser.parse_args()

    source = args.source.resolve()
    destination = args.destination.resolve()
    if not source.is_file():
        raise SystemExit(f"Source audio not found: {source}")
    if source == destination:
        raise SystemExit("Destination must differ from source; Mangonur audio processing is non-destructive.")
    destination.parent.mkdir(parents=True, exist_ok=True)

    used_deepfilter = False
    if args.preset == "voice-clean-strong":
        used_deepfilter = run_deepfilter(source, destination)

    if not used_deepfilter:
        ffmpeg = require_binary("ffmpeg")
        fallback = "voice-clean" if args.preset == "voice-clean-strong" else args.preset
        audio_filter = build_filter(fallback, args.gain_db)
        subprocess.run([ffmpeg, "-hide_banner", "-y", "-i", str(source), "-vn", "-af", audio_filter, str(destination)], check=True)

    metadata = {
        "source": str(source),
        "destination": str(destination),
        "requestedPreset": args.preset,
        "gainDb": args.gain_db,
        "deepFilterApplied": used_deepfilter,
        "note": None if used_deepfilter or args.preset != "voice-clean-strong" else "DeepFilterNet was unavailable; standard FFmpeg cleanup was used without dedicated dereverberation.",
    }
    destination.with_suffix(destination.suffix + ".json").write_text(json.dumps(metadata, ensure_ascii=False, indent=2), encoding="utf-8")
    print(json.dumps(metadata, ensure_ascii=False))


if __name__ == "__main__":
    main()
