# Path: scripts/transcribe-captions.py
# Summary: Generates Remotion Caption JSON from local narration audio using faster-whisper word timestamps.
from __future__ import annotations

import argparse
import json
from pathlib import Path


def main() -> None:
    parser = argparse.ArgumentParser()
    parser.add_argument("source", type=Path)
    parser.add_argument("destination", type=Path)
    parser.add_argument("--model", default="small")
    parser.add_argument("--language", default="tr")
    args = parser.parse_args()

    source = args.source.resolve()
    destination = args.destination.resolve()
    if not source.is_file():
        raise SystemExit(f"Narration audio not found: {source}")

    try:
        from faster_whisper import WhisperModel
    except ImportError as exc:
        raise SystemExit("faster-whisper is not installed. Install the optional Mangonur caption dependency first.") from exc

    model = WhisperModel(args.model, device="cpu", compute_type="int8")
    segments, _ = model.transcribe(str(source), language=args.language, word_timestamps=True, vad_filter=True)
    captions: list[dict[str, object]] = []

    for segment in segments:
        for word in segment.words or []:
            start_ms = max(0, round(float(word.start) * 1000))
            end_ms = max(start_ms + 1, round(float(word.end) * 1000))
            probability = getattr(word, "probability", None)
            captions.append({
                "text": str(word.word),
                "startMs": start_ms,
                "endMs": end_ms,
                "timestampMs": start_ms,
                "confidence": float(probability) if probability is not None else None,
            })

    destination.parent.mkdir(parents=True, exist_ok=True)
    destination.write_text(json.dumps(captions, ensure_ascii=False, indent=2), encoding="utf-8")
    print(json.dumps({"captions": len(captions), "destination": str(destination)}, ensure_ascii=False))


if __name__ == "__main__":
    main()
