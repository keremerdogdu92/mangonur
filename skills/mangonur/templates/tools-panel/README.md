# Path: templates/tools-panel/README.md
# Summary: Defines the first local Mangonur Tools panel controls that complement Remotion Studio on Windows and macOS.

# Mangonur Tools Panel

This panel is the action-oriented companion to Remotion Studio.

## Audio section

- Voice volume: gain slider with preview derivative.
- Enhance voice: runs `scripts/audio-tools.py --preset voice-enhance`.
- Remove noise: runs `scripts/audio-tools.py --preset voice-clean`.
- Reduce echo/noise (strong): requests `voice-clean-strong`; DeepFilterNet is used only when installed.
- Keep original: always enabled and not user-disableable.

## Finishing section

- Transition: cut, fade, slide-left, slide-up, zoom.
- Visual effect: none, soft zoom, soft pan, micro shake.
- Captions: generate, enable/disable, then edit position/style in Remotion Studio.

## Caption generation

Use `scripts/transcribe-captions.py`. The first implementation uses `faster-whisper` with word timestamps and writes Remotion Caption JSON. The generated transcript is timing input, not permission to rewrite the approved script.

## UI boundary

The first version may expose processing actions in a compact local web panel while Remotion Studio remains the main preview/timeline surface. Do not add a second full timeline editor.
