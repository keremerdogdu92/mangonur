# Mangonur Architecture

Mangonur should be developed as a reusable production engine with channel/profile-specific configuration rather than as a single hard-coded video project.

## Architectural Principles

1. Production data should be separated from rendering code.
2. Raw source assets should never be destructively overwritten.
3. Channel-specific behavior should be implemented through profiles/configuration where possible.
4. Human approval gates should be explicit and preserved.
5. Finalized productions should be reproducible from archived metadata.
6. Validation should fail visibly instead of silently repairing unknown problems.
7. The core engine should remain reusable for other short-form channels and formats.
8. Mandatory production guardrails should be enforced programmatically rather than relying on prompt authors to remember them.

## Logical Layers

### 1. Skill / Orchestration Layer

Responsibilities:

- guide the user through topic selection
- research candidate topics
- generate scripts
- request approval at defined gates
- create scene plans
- generate image prompts
- coordinate audio, captions, preview, rendering, and archive steps

The skill should orchestrate the system rather than contain all implementation logic itself.

### 2. Production Data Layer

Primary concept: a machine-readable production manifest.

The manifest should eventually include:

```text
production
├─ identity
├─ profile
├─ topic
├─ script
├─ scenes[]
├─ assets
│  ├─ visuals
│  ├─ voice
│  ├─ music
│  └─ sfx
├─ captions
├─ transitions
├─ audioMix
├─ render
├─ approvals
└─ archiveMetadata
```

JSON Schema or an equivalent typed schema should validate this format before render.

### 3. Image Prompt Compilation Layer

Responsibilities:

- convert approved scene intent into model-ready image prompts
- keep narration and subtitle text separate from visible image content
- preserve explicitly approved in-scene text requirements
- append mandatory Mangonur image-generation guardrails automatically
- guarantee one independent image prompt per visual asset
- support generation batches without turning a batch into a collage or storyboard
- preserve channel style and recurring character constraints
- preserve caption-safe composition requirements

The source of truth for mandatory image-generation constraints is `docs/IMAGE_PROMPT_RULES.md`.

The compiler must prevent two known failure modes:

1. multiple requested scenes being combined into a collage, storyboard, contact sheet, split screen, or multi-panel image;
2. narration, subtitle, caption, dialogue, or script text being rendered directly into scene artwork when that text is intended for post-production overlays.

These constraints must be applied automatically at prompt compilation time rather than depending on the scene writer to repeat them manually.

### 4. Media Processing Layer

Responsibilities:

- voice cleanup
- noise reduction
- echo / room reduction
- loudness normalization
- peak limiting
- optional format conversion
- preview asset preparation

The implementation may use FFmpeg and dedicated cleanup tools, but command construction and presets should be centralized instead of scattered through production scripts.

### 5. Caption Layer

Responsibilities:

- transcription import / generation
- timing normalization
- phrase / word segmentation
- visual styling
- safe-area enforcement
- overflow detection
- collision prevention

Caption data should remain independent from the visual React component so different styles can reuse the same timing data.

### 6. Remotion Rendering Layer

Responsibilities:

- composition registration
- scene sequencing
- media playback
- camera motion
- transitions
- captions
- SFX/music/narration playback
- preview and final render profiles

Recommended internal separation:

```text
remotion/src/
├─ compositions/
├─ components/
├─ scenes/
├─ captions/
├─ transitions/
├─ audio/
├─ hooks/
├─ config/
└─ validation/
```

Production-specific values should enter through props / manifest data rather than direct edits to shared components.

### 7. Validation Layer

Validation should operate before expensive rendering.

Categories:

- schema validation
- asset validation
- image prompt validation
- timing validation
- caption validation
- audio validation
- render configuration validation
- archive completeness validation

Image prompt validation should verify at minimum that one scene maps to one expected visual asset, subtitle-rendering instructions are not accidentally present, and explicitly approved in-scene text remains distinguishable from narration/caption text.

Severity levels:

- ERROR — must be fixed before final render
- WARNING — render is allowed but review is required
- INFO — useful production metadata

### 8. Archive / Similarity Layer

Only finalized productions become long-term comparison references.

The archive should support later analysis of:

- topic reuse
- hook reuse
- script similarity
- narrative structure
- scene structure
- repeated visual motifs
- music/SFX reuse
- transition repetition
- do-not-repeat directives

This layer should be advisory first. Automatic blocking should only be introduced for explicitly defined hard constraints.

## Proposed Repository Evolution

```text
mangonur/
├─ README.md
├─ docs/
├─ skills/
│  └─ mangonur/
├─ packages/
│  ├─ production-schema/
│  ├─ prompt-compiler/
│  ├─ media-processing/
│  ├─ caption-engine/
│  ├─ validation/
│  └─ similarity/
├─ remotion/
├─ templates/
├─ assets/
└─ productions/
```

This is a target architecture, not a requirement to create every folder immediately. Implementation should move into this structure incrementally as current working source files are imported and reviewed.

## Immediate Implementation Order

1. Import the current Mangonur skill without rewriting it blindly.
2. Import the current Remotion implementation and inspect its existing structure.
3. Identify the current image prompt generation logic and implement the mandatory guardrail from `docs/IMAGE_PROMPT_RULES.md` without changing unrelated prompt behavior.
4. Identify the current audio cleanup scripts / commands and preserve the known-good chain.
5. Identify the current caption implementation and overflow handling.
6. Define the first production manifest from the existing Zanzibar production.
7. Refactor only after the known-good production can be reproduced.

This ordering prevents architectural cleanup from destroying working production behavior.
