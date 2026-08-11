# Mangonur Skill

Mangonur is a gated short-form video production workflow for ChatGPT and Codex-compatible skill surfaces.

## What it does

1. Researches recently viral topics.
2. Lets the user choose a topic.
3. Verifies the selected story.
4. Writes a short, factual, lightly humorous Turkish voiceover.
5. Waits for explicit script approval.
6. Splits the approved script into approximately 3-5 second visual beats.
7. Produces standalone, continuity-aware image-generation prompts.

## Important behavior

Mangonur uses hard workflow gates.

It does not proceed from script drafting to shot generation until the user approves the script.

Once a session is active, feedback is applied to the current production phase instead of silently restarting the workflow.

## Structure

- `SKILL.md` — main activation and workflow instructions
- `agents/openai.yaml` — optional ChatGPT/OpenAI UI metadata
- `references/topic-research.md` — viral-topic research and ranking
- `references/script-style.md` — narration and humor standard
- `references/visual-style.md` — recurring visual language and continuity rules
- `references/output-format.md` — user-facing output templates
- `references/evals.md` — trigger, gate, focus, and accuracy tests

## Suggested test prompt

`Hadi Mangonur yapalım.`

Expected first behavior: current viral-topic research and a shortlist. It should not jump directly to a script.

## Version

Mangonur v1.6


## v1.4 additions
- Mangonur orchestrates Remotion assembly/render.
- Locked narration becomes the master timeline.
- Forced-aligned word captions with frame-driven active-word highlight.
- Shorts/TikTok/Reels top UI safe zone + caption band.
- Approval-based A/B/C SFX and background-music audition workflow with local candidate folders and license manifest.
- Review render and final mix gates.


## v1.5 additions
- Google Drive shared workspace + machine-local Remotion workspace.
- Environment-variable based path resolution (`MANGONUR_WORKSPACE`, `MANGONUR_LOCAL_WORKSPACE`).
- Shared reusable SFX/music library with project-level candidates and selected assets.
- Local-only Node/Remotion caches and dependencies.
- Versioned review/final render publishing and conflict rules for multi-computer use.


## v1.6 additions
- Release-based self-update architecture for Windows and macOS local installations.
- SHA-256 verified staged updates with rollback-safe version folders.
- Remotion Studio editability contract for low-risk CapCut-like adjustments.
- Interactive scene/caption layers where supported by Remotion Studio.
- Lightweight project revision/editor metadata for safer sequential collaboration.
- Cross-platform launcher/update scripts; Google Drive remains the release source, not the execution root.


## Audio & Finishing

Mangonur v1.7 adds low-risk Remotion Studio controls for master levels, captions, transitions and visual effects, plus non-destructive local audio cleanup and automatic caption-generation helpers. See `references/audio-finishing.md`.
