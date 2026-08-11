# Mangonur Production Workflow

This document defines the intended end-to-end production flow. It is the operational source of truth for how a Mangonur video should move from topic discovery to final archive.

## 1. Topic Discovery

Research recent, relevant, and potentially viral subjects suitable for the target channel profile.

Output:

- candidate topics
- why each topic may work
- obvious factual / policy risks
- expected visual potential

Human gate: select one topic.

## 2. Script Draft

Create a concise short-form script with a strong hook, clear progression, and an ending that justifies the watch time.

For the Mangonur profile, humor can be used where appropriate but should not damage factual clarity.

Output:

- title / working title
- hook
- narration script
- optional on-screen text notes

Human gate: approve or revise the script.

## 3. Scene Planning

Split the approved script into approximately 3–5 second scenes according to narration timing and visual clarity.

Each scene should define:

- scene id
- narration segment
- visual intent
- recurring character requirements
- foreground objects
- background requirements
- camera / motion suggestion
- caption constraints if needed

Output: structured scene plan.

## 4. Image Prompt Generation

Generate prompts from the approved scene plan.

Rules:

- Respect the selected channel style and character bible.
- Preserve recurring character consistency.
- Reserve safe areas for captions and platform UI.
- Generate in batches of at most 10 images when using systems with a 10-image generation limit.
- Do not silently change approved historical / factual constraints.

Human gate: approve generated visuals or request replacements.

## 5. Voice-Over

Use recorded or generated narration.

The raw voice file should remain preserved separately from processed outputs.

## 6. Voice Processing

Apply the configured voice-processing chain.

Current required capabilities:

- gain adjustment
- noise reduction
- echo / room reduction
- voice enhancement
- optional corrective EQ / dynamics processing
- loudness normalization
- peak protection

Processing should be non-destructive: processed derivatives must not overwrite the original recording.

## 7. SFX and Music Selection

Research or retrieve suitable audio candidates for meaningful moments in the production.

Selection flow:

1. Prepare a small number of meaningful alternatives.
2. Present them as explicit options such as A / B / C.
3. Record the selected option per cue.
4. Keep background music as an independently selectable production asset.
5. Preserve selection metadata in the production manifest.

SFX should be long and clear enough to be perceived, not arbitrary micro-clips with no readable acoustic identity.

Human gate: approve SFX and music choices when alternatives are being compared.

## 8. Remotion Assembly

Build the video from production data rather than embedding production-specific decisions deeply in component code.

Composition should include:

- scene timing
- visual assets
- camera motion
- transitions
- narration
- music
- SFX
- captions

## 9. Automatic Captions

Generate captions from the final narration timing.

Required checks:

- timing alignment
- line length
- overflow
- mobile safe area
- UI collision risk
- readability against background
- final-scene placement adjustments where necessary

Caption generation is not considered complete until layout validation passes.

## 10. Transitions and Camera Motion

Use transitions intentionally rather than applying a transition to every cut.

Preferred rule hierarchy:

- hard cut for normal pacing
- crossfade for softer temporal / conceptual transitions
- push / slide for directional movement
- zoom for emphasis or entering a detail
- pan / Ken Burns motion for static illustrations
- blur or stylized transitions only when justified by the profile

Transitions should remain short enough to preserve short-form pacing.

## 11. Audio Mix

Final mix should establish a predictable hierarchy:

1. narration is always intelligible
2. SFX are perceptible but do not mask narration
3. music supports pacing without competing with speech

Music ducking should be used beneath narration where required.

## 12. Validation

Before final render, validate at minimum:

- expected duration
- missing assets
- scene timing gaps / overlaps
- caption overflow
- caption safe-area compliance
- audio clipping / peak problems
- narration audibility
- invalid file references
- unexpected black frames
- end-frame integrity

Validation should return explicit failures and warnings.

## 13. Preview

Use Remotion Player and/or lower-cost preview renders before the full final render whenever possible.

Review targets:

- pacing
- scene comprehension
- caption placement
- transitions
- SFX timing
- music level
- narration clarity

Human gate: approve or request revision.

## 14. Final Render

Render the approved production using the production manifest and selected quality profile.

Do not mutate the approved manifest during final rendering.

## 15. Final Archive

Archive only approved final productions.

The archive should preserve:

- approved script
- scene plan
- prompts
- production manifest
- final asset selections
- caption data
- transition settings
- render settings
- final notes
- similarity metadata
- do-not-repeat notes

The finalized archive becomes input to future similarity / repetition checks.
