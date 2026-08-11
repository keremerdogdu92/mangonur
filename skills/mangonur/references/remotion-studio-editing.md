# Path: references/remotion-studio-editing.md
# Summary: Defines the safe CapCut-like controls exposed through Remotion Studio and the companion Mangonur local tools panel.

# Mangonur Remotion Studio Editing

## Purpose

Expose a small, safe subset of CapCut-like adjustments without turning Mangonur into a general-purpose NLE.

## Remotion Studio controls

Expose low-risk, reversible values:

- scene visual position, scale and rotation;
- caption position, font size, scale and rotation;
- captions enabled/disabled;
- narration, music and SFX master levels;
- transition preset and duration;
- simple visual effect preset;
- simple frame-driven keyframes for opacity, scale, translate and rotate.

Prefer `Interactive.*` elements with descriptive names. Keep editable CSS inline whenever practical. Prefer `scale`, `translate` and `rotate` over a combined `transform`.

## Companion local tools panel

File-processing actions should not be disguised as normal Studio props. Use the Mangonur local tools panel for:

- source gain changes;
- voice enhancement;
- denoise;
- best-effort echo/reverb cleanup;
- automatic transcription/caption JSON generation.

The tools panel must create derivatives and never overwrite source recordings.

## Keep controlled

Do not expose canonical word alignment, narration master timing, project IDs, filesystem roots, approval state, publishing rules, arbitrary commands, API credentials or provider secrets as casual editor controls.

## Workflow

1. Assemble a deterministic local Remotion project.
2. Run the Mangonur update check.
3. Open Remotion Studio for live visual/audio mix controls.
4. Use the local tools panel for destructive-style preprocessing actions, which actually remain non-destructive derivatives.
5. Save durable settings to project state.
6. Revalidate captions, timing, safe areas and audio intelligibility.
7. Produce a review render before final publishing.

## Design rule

Expose controls that remove routine back-and-forth. Keep complex timeline surgery automated until there is a repeated editing need.
