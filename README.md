# Mangonur

Mangonur is a modular AI-assisted short-form video production pipeline focused on repeatable, reviewable, and production-ready content creation.

The project combines topic research, script generation, scene planning, image prompt generation, voice-over processing, SFX/music selection, Remotion-based editing, automatic captions, transition logic, validation, rendering, and finalized-production archiving.

## Current Goal

Build a reliable workflow that can take a topic from idea to a reviewed short-form video while keeping every production decision traceable and reusable.

## Core Workflow

1. Research recent / viral topic candidates.
2. Select a topic.
3. Generate and review the script.
4. Split the approved script into 3–5 second scenes.
5. Generate scene image prompts in batches of up to 10.
6. Produce or import scene visuals.
7. Record / generate voice-over.
8. Clean and enhance voice audio.
9. Select and mix SFX and background music.
10. Build the edit in Remotion.
11. Generate and validate captions.
12. Add transitions and camera motion.
13. Run final audio / visual validation.
14. Render and review.
15. Archive the finalized production and similarity metadata.

## Current Capabilities

- Voice volume control
- Voice cleanup and enhancement
- Noise and echo reduction
- SFX selection and placement
- Background music selection and mixing
- Automatic captions
- Caption safe-area and overflow checks
- Remotion-based composition and rendering
- Scene-based short-form workflow
- Finalized production archive design

## In Progress

- Standard transition engine
- Consistent audio mastering targets
- Automated production validation
- Similarity / repetition checks against previous finalized videos
- Reusable production templates

## Repository Structure

```text
mangonur/
├─ README.md
├─ docs/
│  ├─ ROADMAP.md
│  ├─ WORKFLOW.md
│  └─ ARCHITECTURE.md
├─ skills/
│  └─ mangonur/
├─ remotion/
├─ scripts/
├─ templates/
├─ assets/
└─ productions/
```

Folders will be introduced incrementally as the implementation is moved into the repository. Empty placeholder trees are intentionally avoided until the corresponding source files are ready.

## Production Archive Policy

Only finalized / approved videos should enter the permanent production archive. Each archived production should preserve enough metadata to prevent accidental repetition and allow the final output to be reproduced later.

Recommended per-production records:

- approved script
- scene plan
- image prompts
- selected audio assets
- caption data
- production settings
- final review notes
- similarity / fingerprint metadata
- do-not-repeat notes

## Versioning

Semantic Versioning will be used for stable pipeline releases.

- `v0.1.x` — repository foundation and current Mangonur workflow
- `v0.2.x` — transition system
- `v0.3.x` — audio mastering and validation
- `v0.4.x` — production archive and similarity checks
- `v1.0.0` — stable end-to-end production pipeline

## Status

Early production framework. The current priority is to migrate the proven Mangonur workflow into source-controlled, testable modules without losing existing working behavior.
