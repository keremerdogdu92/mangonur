# Mangonur Roadmap

This roadmap converts the current working Mangonur workflow into a maintainable production pipeline.

## Milestone 0 — Repository Foundation

Goal: establish source control and preserve the current workflow before adding new behavior.

Deliverables:

- Repository documentation
- Architecture and workflow definitions
- Current Mangonur skill imported as source of truth
- Current Remotion project imported
- Existing audio cleanup logic documented
- Existing caption behavior documented
- Existing SFX/music selection workflow documented
- First finalized production archived as a reference case

Exit criteria:

- Current known-good workflow can be reconstructed from the repository
- No production behavior depends only on chat history or ad-hoc local knowledge

## Milestone 1 — Post-Production Standardization

Goal: turn editing features into explicit reusable systems.

### Audio

- Voice gain control
- Loudness normalization
- Peak limiting
- Noise reduction
- Echo / room reduction
- Voice enhancement
- Music ducking under narration
- SFX gain rules
- Final audio validation

### Captions

- Automatic transcription / caption generation
- Word or phrase timing
- Caption style presets
- Mobile safe-area rules
- Overflow detection
- Maximum line / character rules
- Final-frame caption positioning rules

### Transitions and Motion

- Hard cut
- Crossfade
- Push / slide
- Zoom transition
- Pan / Ken Burns motion
- Blur transition where appropriate
- Scene entrance / exit rules
- Transition duration constraints

Exit criteria:

- A production can use named presets rather than one-off editing values
- Audio and captions pass deterministic validation checks

## Milestone 2 — Production Manifest

Goal: represent every video with a machine-readable production specification.

Create a production manifest describing:

- title
- topic
- hook
- target duration
- aspect ratio
- script
- scenes
- visual prompts
- voice-over source
- SFX choices
- music choice
- caption settings
- transition settings
- render settings
- approvals / revision notes

Exit criteria:

- Remotion composition can be driven primarily by production data instead of manual code edits

## Milestone 3 — Preview and Review Loop

Goal: make iteration fast before final rendering.

Deliverables:

- Remotion Player preview workflow
- Low-cost / low-resolution preview mode
- Scene-level preview
- Audio-only preview where useful
- Caption layout preview
- Production validation report before final render

Exit criteria:

- Most revisions can be decided without a full-resolution final render

## Milestone 4 — Finalized Production Archive

Goal: preserve approved content and prevent repetitive output.

For each finalized video store:

- final script
- scene structure
- image prompts
- production manifest
- final audio decisions
- caption configuration
- transition configuration
- render metadata
- final notes
- hook fingerprint
- narrative structure fingerprint
- visual motif tags
- do-not-repeat list

Exit criteria:

- New production planning can inspect past approved content before script approval

## Milestone 5 — Similarity Guard

Goal: reduce channel-level repetition and templated-content risk.

Checks should compare new proposals against finalized productions using:

- topic similarity
- hook similarity
- sentence / script similarity
- scene-order similarity
- visual motif repetition
- punchline structure
- recurring transition patterns
- music / SFX reuse frequency

The system should warn rather than automatically block unless a hard rule is explicitly configured.

Exit criteria:

- Every new production receives a repetition-risk report before final approval

## Milestone 6 — Automation Layer

Goal: automate routine steps while preserving human approval gates.

Candidate automation stages:

1. Topic research
2. Candidate ranking
3. Script draft
4. Scene split
5. Prompt generation in batches of 10
6. Asset collection / generation
7. Caption generation
8. Audio processing
9. Remotion assembly
10. Validation
11. Preview
12. Final render after approval
13. Archive after final approval

Human approval should remain explicit for:

- topic selection
- script approval
- visual direction
- SFX/music selection when alternatives are being evaluated
- final video approval

## Milestone 7 — Channel / Format Profiles

Goal: reuse the engine outside a single content style.

Potential profiles:

- Mangonur history shorts
- Mascot-led explainers
- Hearing / medical educational shorts
- Character-led recurring series
- Static illustration + camera-motion format
- More heavily animated format

Each profile should override configuration rather than fork the core engine.

## Milestone 8 — Stable v1.0

Requirements:

- Reproducible installation
- Documented dependencies
- Stable production manifest schema
- Reusable Remotion components
- Audio pipeline presets
- Caption presets
- Transition presets
- Validation suite
- Preview workflow
- Finalized-production archive
- Similarity guard
- At least several completed productions validated through the same pipeline

At this point the project should behave as a reusable short-form video production system rather than a collection of scripts.
