# Path: references/audio-finishing.md
# Summary: Defines the first cross-platform Audio & Finishing controls for Mangonur Studio and the local tools panel.

# Mangonur Audio & Finishing

## Goal

Expose common finishing operations without turning Mangonur into a full nonlinear editor.

## First-release controls

### Studio-safe live controls

These are reversible composition parameters and may be edited in Remotion Studio:

- narration volume;
- music volume;
- SFX master volume;
- captions enabled/disabled;
- caption position, scale and font size;
- scene visual position, scale and rotation;
- visual effect preset: `none`, `soft-zoom`, `soft-pan`, `micro-shake`;
- transition preset: `cut`, `fade`, `slide-left`, `slide-up`, `zoom`;
- transition duration in frames within validated limits.

Durable values must be written to the project manifest or composition props before review rendering.

### Local processing actions

These operations create new files and therefore run through the local Mangonur tools worker rather than directly inside the render graph:

- increase/decrease source audio gain;
- normalize voice loudness;
- speech enhancement;
- noise reduction;
- basic room/echo cleanup;
- optional stronger denoise/dereverb when DeepFilterNet is available;
- automatic caption transcription with word timestamps.

Never overwrite the source recording. Write derivatives below the project local `processed/` area and preserve provenance in metadata.

## Audio presets

`voice-level` changes gain only.

`voice-enhance` applies speech-oriented filtering, light compression and loudness normalization.

`voice-clean` applies high-pass/low-pass filtering, FFT denoise, light compression and loudness normalization.

`voice-clean-strong` requests DeepFilterNet when available. If it is not available, fall back to the standard cleanup preset and clearly report that dedicated dereverberation was not applied.

## Automatic captions

Generate Remotion caption JSON using this durable shape:

```json
{
  "text": "example",
  "startMs": 0,
  "endMs": 500,
  "timestampMs": 0,
  "confidence": null
}
```

Prefer word timestamps. Preserve the canonical approved script separately; transcription timing must not silently rewrite approved wording.

## Safety and quality rules

- Do not normalize music and narration with the same preset.
- Do not destructively overwrite originals.
- Prevent clipping after user gain changes.
- Review speech intelligibility after aggressive denoise.
- Treat dereverberation as best-effort; excessive processing can create metallic artifacts.
- If narration audio changes materially after alignment, invalidate and regenerate alignment/caption timing.
