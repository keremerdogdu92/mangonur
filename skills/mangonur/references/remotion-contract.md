# Mangonur -> Remotion Contract

Mangonur owns workflow decisions, approvals, asset selection, and timing policy. Remotion is the deterministic composition/render engine. The user should normally invoke Mangonur, not manually coordinate both skills.

## Inputs
- approved scene images/video assets
- scene timeline derived from locked narration
- locked narration audio
- canonical word-level alignment JSON
- approved SFX files + cue times
- approved background music
- production settings

## Caption contract
Render captions as React/Remotion overlay elements driven by `useCurrentFrame()`. Default: 3-4 words per card, active word yellow, inactive words white, no gaps while speech is continuous, max two lines. Never use ASS `\k` / `\kf` as the primary karaoke renderer.

## Vertical safe area
1080x1920. Keep top 0-10% clear for platform UI. Primary caption band is 12-24%; default caption top around 13-15%. Keep caption width about 78-84% and avoid important visuals behind it.

## Render
30 fps default. Narration is the master clock. If narration changes, downstream scene/caption/audio timing must be regenerated or revalidated.


## Shared/local storage contract

- Durable source assets and delivery renders live under `MANGONUR_WORKSPACE`.
- The active Remotion app, `node_modules`, caches, temp frames, and transient render intermediates live under `MANGONUR_LOCAL_WORKSPACE`.
- Before assembly, copy or hydrate required shared project assets into the local working project.
- After review/final render, copy only durable outputs and updated manifests back to the shared project.
- Never run package installation inside the Google Drive tree.


## Studio editability contract (v1.6)

When creating or revising Mangonur Remotion markup, expose low-risk visual changes through Remotion Studio where practical. Follow `references/remotion-studio-editing.md`.

Priority editable controls:
- scene image/video position, scale and rotation;
- caption position, font size, scale and rotation;
- simple opacity and entrance/exit keyframes when the markup remains Studio-editable;
- composition props that are safe for a non-developer editor to change.

Do not sacrifice deterministic rendering or maintainability merely to expose every property. Complex timing, canonical alignment, narration lock, project IDs, file paths and approval state remain controlled by Mangonur.
