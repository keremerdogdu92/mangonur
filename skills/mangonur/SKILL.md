---
name: mangonur
description: Mangonur short-form video production workflow. Use when the user says "hadi mangonur yapalım", "mangonur yapalım", asks for a Mangonur video, invokes @mangonur, or continues an active Mangonur production session. Research recent viral topics, guide topic selection, write an accurate but humorous script, wait for script approval, then split the approved script into 3-5 second visual beats and produce consistent image-generation prompts. Do not use for unrelated video work unless the user explicitly asks to use Mangonur.
---

# Mangonur

Create short-form vertical videos through a gated, focused production workflow.

## Runtime bootstrap and self-maintenance

When Desktop Commander or equivalent authorized local tooling is available, treat the installed ChatGPT skill as a stable bootstrap and the machine-local `<MANGONUR_SKILL_HOME>/current` release as the current runtime specification. Before a new production session: run the local updater when available; read the refreshed `current/SKILL.md` and `runtime-requirements.json`; run `current/scripts/doctor.py`; and use the current local specification for the remainder of the session. If Doctor reports a missing required dependency and authorized local tooling can safely repair it, repair only the named requirement, preserve user files, and rerun Doctor. Prefer lightweight local dependencies and worker offload for optional heavy components. Never execute skill files directly from Google Drive. If update or repair fails, keep the last known-good runtime and explain only the blocking issue. Read `references/update-system.md` for the full contract.

## Core behavior

Treat every Mangonur session as a stateful production process.

Once Mangonur is activated, remain focused on the active video until either:

- the workflow reaches `COMPLETE`, or
- the user explicitly asks to stop, cancel, abandon, or start a different Mangonur video.

Do not silently restart the workflow.
Do not introduce unrelated tasks.
Do not skip required approval gates.
Interpret ordinary feedback as feedback about the current phase unless the user explicitly changes phases.

Default working language and voiceover language: Turkish.
Use another language only when the user requests it.

## Required workflow states

Use these states in order:

1. `TOPIC_DISCOVERY`
2. `TOPIC_SELECTED`
3. `SCRIPT_DRAFT`
4. `SCRIPT_APPROVAL`
5. `SHOT_BREAKDOWN`
6. `IMAGE_PROMPTS`
7. `ASSET_APPROVAL`
8. `VOICE_LOCK`
9. `ALIGNMENT`
10. `SFX_DISCOVERY`
11. `AUDIO_SELECTION`
12. `REMOTION_ASSEMBLY`
13. `REVIEW_RENDER`
14. `FINAL_MIX`
15. `COMPLETE`

The state transition rules are strict.

### State 1 — TOPIC_DISCOVERY

When a new Mangonur session starts:

1. Research topics that became meaningfully viral, unusually discussed, or rapidly rising during roughly the last 7-30 days.
2. Prefer topics with strong short-video potential.
3. Use current web research whenever web access is available.
4. Verify why each topic is timely instead of relying on memory.
5. Prioritize topics that can be understood quickly and represented visually.
6. Prefer factual, historical, scientific, cultural, technological, unusual-event, or broadly interesting stories over low-context celebrity gossip.
7. Avoid suggesting a topic merely because it is important; it should also have a strong hook.
8. Present a compact shortlist, normally 5-8 topics.
9. Stop and ask the user which topic to use.

Do not write the full script during topic discovery.

For the detailed ranking method, read `references/topic-research.md`.

### State 2 — TOPIC_SELECTED

After the user selects a topic:

1. Lock the selected topic.
2. Research the facts needed to tell the story accurately.
3. Resolve material dates, names, chronology, numbers, and common misconceptions.
4. Prefer primary or highly reliable sources for factual claims.
5. Separate verified facts from uncertain or disputed claims.
6. Build a compact factual backbone before writing.
7. Do not overwhelm the user with research notes unless they are useful to a decision.
8. Proceed to the first script draft when the factual backbone is sufficient.

If the selected topic is time-sensitive, verify current information again before drafting.

### State 3 — SCRIPT_DRAFT

Write one complete short-form voiceover script.

The script must:

- open with a strong hook immediately;
- explain the story clearly without requiring prior knowledge;
- move quickly;
- use humor naturally;
- preserve factual accuracy;
- avoid forcing a joke into every sentence;
- escalate curiosity;
- have a satisfying ending, reveal, punchline, or payoff;
- sound natural when spoken aloud;
- avoid unnecessary headings inside the voiceover itself;
- avoid visual directions inside the voiceover unless the user asks for them.

Default target length:
- approximately 35-70 seconds unless the user sets a different duration.

Read `references/script-style.md` before drafting.

After the script, move to `SCRIPT_APPROVAL`.

### State 4 — SCRIPT_APPROVAL

This is a hard gate.

Show the script and ask for approval or revisions.

Do not create:
- shot lists,
- scene timing,
- image prompts,
- animation prompts,
- final image assets

until the user clearly approves the script.

Treat messages such as the following as approval when context clearly refers to the script:

- "tamam"
- "okey"
- "bu iyi"
- "devam"
- "senaryo tamam"
- "onay"
- equivalent explicit approval

If the user requests a change, revise the script and remain in `SCRIPT_APPROVAL`.

Do not interpret revision feedback as permission to advance.

### State 5 — SHOT_BREAKDOWN

Only after script approval:

1. Preserve the approved voiceover wording unless the user explicitly allows script edits.
2. Estimate natural spoken timing.
3. Divide the voiceover into visual beats that normally last 3-5 seconds.
4. A beat may be shorter or longer only when pacing clearly benefits.
5. Each beat must communicate one visually legible idea.
6. Avoid changing images merely because 4 seconds elapsed; change when the narration introduces a meaningful new visual beat.
7. Maintain continuity of recurring characters, environments, clothing, props, geography, era, and visual language.
8. Ensure the first 1-2 beats are especially strong visually.

For every beat identify:

- scene number;
- approximate time range;
- exact voiceover segment;
- concise visual purpose;
- continuity requirements.

Read `references/visual-style.md` and `references/output-format.md`.

### State 6 — IMAGE_PROMPTS

For every approved beat, write a complete image-generation prompt.

Each prompt must be independently usable while remaining consistent with the other scenes.

Every prompt should define, when relevant:

- vertical `9:16` composition;
- the recurring Mangonur visual style;
- exact characters and their appearance;
- location and historical/cultural context;
- character action and expression;
- important props;
- foreground, midground, and background;
- camera framing;
- lighting and mood;
- a mandatory caption-safe area covering the upper 20-25% of the frame by default;
- no faces, text, clocks, flags, or important storytelling objects inside that caption-safe area;
- exclusions that prevent common continuity mistakes.


For standard vertical Mangonur scenes, include this caption-layout requirement in every independent image prompt unless the user explicitly chooses another caption layout:

`Reserve platform-safe headroom for vertical short-video UI and captions. Keep the top 10% of the frame free from text and critical storytelling content. Reserve the 12%-24% vertical band as a clean caption-safe area with simple low-detail background. Do not place faces, clocks, flags, important objects, or small readable text inside either safe region.`

If a scene genuinely requires an important element in the upper area, move the caption-safe region to another clearly empty part of the frame and state that alternative placement explicitly.

Every independent image prompt must also enforce these generation guardrails:

- one visual beat per generated image;
- one complete standalone scene, never a collage, storyboard grid, contact sheet, split-screen, comparison sheet, character sheet, or multi-panel composition;
- narration, subtitle, caption, dialogue, and script wording are context for scene construction only and must not appear as rendered text in the image unless visible in-world text is explicitly required by the scene;
- batch generation means multiple separate image outputs, never multiple scenes combined into one image.

Append this guardrail to every standard image prompt unless the user explicitly requires a legitimate in-world text element:

`Single standalone scene. One visual beat only. No collage, no storyboard, no contact sheet, no split-screen, no comparison sheet, no character sheet, and no multi-panel composition. Do not render subtitles, captions, narration, dialogue, or script text inside the image. Treat all narration and subtitle wording only as scene context. No unnecessary visible text.` 

Do not use vague references such as:
- "same character as before";
- "same room";
- "same style";

unless the image tool being used can actually see the relevant reference image.
Text prompts intended to work independently must restate necessary continuity details.

Do not generate images automatically unless the user explicitly asks for image generation.
The default deliverable at this phase is the ordered prompt list.

### State 7 — ASSET_APPROVAL

Confirm the chosen/generated visuals are ready for assembly. Do not silently replace approved assets.

### State 8 — VOICE_LOCK

Use the final narration recording as the master timeline. Prefer one continuous WAV/clean audio take. Once locked, do not change speed, trim, or wording without invalidating downstream alignment.

### State 9 — ALIGNMENT

Create word-level timing for the canonical approved script against the locked final voice. Prefer forced alignment. The canonical script is the text source of truth; alignment determines timing, not spelling. If audio changes, rerun alignment.

### State 10 — SFX_DISCOVERY

Read `references/shared-workspace.md` and `references/audio-sfx-workflow.md`. Resolve the shared workspace before downloading or generating audio. Analyze each scene/beat and propose only useful sound moments. Research several license-appropriate candidate SFX and background-music options. Download short candidate files to a clearly named local audition folder when tools allow. Group candidates by slot as A/B/C (or more) and tell the user exactly which files to audition. Do not place unapproved audio in the final mix.

### State 11 — AUDIO_SELECTION

Wait for compact user choices such as `1C 2A 3B 4C`. Treat the mapping as authoritative. If the user rejects a slot, research/download a fresh candidate set only for that slot. Background music is selected through the same process. Lock selected audio assets before assembly.

### State 12 — REMOTION_ASSEMBLY

Mangonur is the orchestrator; Remotion is the assembly/render engine. Read `references/shared-workspace.md` and `references/remotion-contract.md`. Assemble from the local working copy, not directly from streamed Drive files. Build the video from approved scenes, locked narration, aligned captions, selected SFX and selected background music. Captions must be a separate React overlay layer, not ASS/burn-in timing logic. Use frame-driven active-word highlighting. When practical, expose low-risk scene visual, caption, transition, visual-effect and master-volume controls through Remotion Studio using `references/remotion-studio-editing.md`. For source gain, enhancement, denoise, best-effort echo/reverb cleanup and automatic transcription, read `references/audio-finishing.md` and use non-destructive local processing tools. Do not expose canonical timing, approval state, secrets, or filesystem policy as casual editor controls.

### State 13 — REVIEW_RENDER

Produce a review render and check scene timing, caption continuity, safe-area placement, active-word sync, SFX timing, music balance, and platform UI safety. Apply focused fixes without silently changing the approved script or asset selections.

### State 14 — FINAL_MIX

Finalize narration level, SFX level, background music ducking, fades, transitions and output loudness without obscuring speech. If source audio needs cleanup, use non-destructive derivatives and invalidate downstream alignment when timing materially changes. Then render the delivery file.

### State 15 — COMPLETE

Before marking complete, sync the final project manifest, approved audio assets, and delivery render back to the shared workspace. Local caches, `node_modules`, temporary frames, and disposable intermediates must remain local-only.

A Mangonur production is complete when:

- the topic is locked;
- the script is approved;
- the script has been divided into visual beats;
- every beat has a usable image prompt;
- final narration is locked;
- captions are aligned;
- SFX/music selections are locked or explicitly skipped;
- Remotion review/final render is complete.

At completion provide a compact summary of:
- final topic;
- approximate video duration;
- number of scenes.

Do not restart topic discovery unless the user asks for another Mangonur video.

## Focus lock

While a Mangonur session is active:

- Keep the selected topic and current phase stable.
- Treat corrections as modifications to the current artifact.
- Do not propose a new topic after topic selection unless the user rejects the current topic.
- Do not rewrite an approved script during shot breakdown merely to make timing easier.
- Do not expand the project into editing, music, voice cloning, animation, publishing, SEO, or analytics unless the user explicitly asks.
- If the user asks a small question needed to finish the active video, answer it and then continue from the same workflow state.
- If the user temporarily asks an unrelated question, answer only if necessary, then preserve the Mangonur state. Do not silently abandon the production.

## Research rules

When research is required:

- Use web search if available.
- For recent topics, verify publication date and event date.
- Prefer original reporting, official sources, primary documents, reputable news organizations, or authoritative references.
- Do not invent virality metrics.
- Describe weak virality evidence as weak.
- Cross-check surprising factual claims.
- Avoid repeating social-media misinformation just because it is viral.
- If reliable evidence contradicts the viral framing, say so.

## Safety and factual integrity

Humor must not require fabricating a factual event.

Clearly distinguish:
- documented fact;
- plausible interpretation;
- joke;
- disputed claim.

For deaths, disasters, violence, or sensitive historical events, humor should target absurd circumstances, systems, rivalries, bureaucracy, irony, or the storytelling situation rather than victims' suffering.

Do not turn speculation into narration presented as fact.

## Output discipline

Keep user-facing responses appropriate to the current state.

During `TOPIC_DISCOVERY`:
- shortlist topics and wait.

During `SCRIPT_APPROVAL`:
- show the script and wait.

During `SHOT_BREAKDOWN` and `IMAGE_PROMPTS`:
- give production-ready structured output.

Do not dump every internal workflow rule or research note into the conversation.

## Reference files

Read only the references needed for the current phase:

- `references/topic-research.md` — discovery and ranking
- `references/script-style.md` — narration and humor
- `references/visual-style.md` — image language and continuity
- `references/output-format.md` — production deliverable format
- `references/evals.md` — behavior and trigger tests
- `references/remotion-studio-editing.md` — safe interactive Studio controls
- `references/update-system.md` — local release/update architecture


## Shared workspace requirement

When `MANGONUR_WORKSPACE` is available, use it as the shared source of truth for reusable media, project manifests, approved assets, and delivery renders. Use `MANGONUR_LOCAL_WORKSPACE` for machine-local Remotion builds, caches, temporary media, and working copies. Read `references/shared-workspace.md` before creating or moving project files.

Never assume a fixed Google Drive letter or user profile path. Resolve both roots from environment variables first. If they are missing, stop file operations and ask for workspace setup rather than inventing paths.
