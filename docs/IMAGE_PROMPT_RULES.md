# Mangonur Image Prompt Rules

This document is the source of truth for image-generation prompt constraints in Mangonur.

## Goals

Mangonur scene images must be generated as clean production assets for later editing in Remotion. The image-generation stage must not pre-compose subtitles, combine several requested images into one canvas, or create storyboard-style outputs.

## Mandatory Output Rules

Every requested image must follow all of these constraints:

1. Generate one complete standalone scene per image.
2. Do not combine multiple requested scenes into one image.
3. Do not create a collage, contact sheet, storyboard, grid, split screen, comparison sheet, multi-panel layout, or multiple alternative versions inside one image.
4. Do not render subtitles, captions, narration, dialogue, script text, or production notes into the image.
5. Text supplied for narration or captions is contextual input only. It must not be treated as visible typography.
6. Visible text is allowed only when explicitly required as part of the scene itself.
7. Keep the configured subtitle-safe area visually uncluttered for post-production captions.
8. Do not fill reserved caption space with decorative labels, headings, or unnecessary typography.

## Allowed In-Scene Text

Visible text may be generated only when the approved scene explicitly needs it as a visual storytelling element, for example:

- a clock display
- a date
- a newspaper headline
- a street or building sign
- a map label
- a historical document detail
- an interface element that is genuinely part of the scene

If visible text is not explicitly requested, the generated image should contain no text.

## Mandatory Prompt Guardrail

The prompt compiler must append the following semantic guardrail to every scene image prompt:

> Single standalone scene. No collage, no storyboard, no contact sheet, no split screen, no comparison sheet, no multi-panel composition, and no multiple scene variants in one image. Do not render subtitles, captions, narration, dialogue, script text, production notes, or unnecessary labels inside the image. Treat narration and subtitle text as context only. Visible text is allowed only when explicitly required as an in-scene visual element. Keep the configured caption-safe area clean for post-production overlays.

The implementation may adapt wording for a specific image model, but it must preserve every semantic constraint above.

## Prompt Compiler Requirement

These rules must not rely on an operator or language model remembering to add them manually.

When the executable Mangonur skill and prompt-generation code are imported into this repository, the image prompt compiler must:

1. build the scene-specific visual prompt;
2. remove accidental instructions that ask the image model to draw subtitles or narration;
3. append the mandatory guardrail automatically;
4. preserve explicitly approved in-scene text requirements separately;
5. emit one prompt per image asset;
6. batch prompts for generation without merging their visual outputs into a collage.

## Batch Semantics

Mangonur may request up to the supported batch limit, currently planned around batches of at most 10 images where required by the generation system.

A batch means multiple independent image-generation requests or independent image outputs. It never means composing all requested scenes into one image.

Example:

```text
Batch 1
- scene-01 -> image-01
- scene-02 -> image-02
- scene-03 -> image-03
...
- scene-10 -> image-10
```

Invalid behavior:

```text
Batch 1
- scene-01 through scene-10 -> one 10-panel image
```

## Future Validation

Once image-generation metadata is available, Mangonur should validate that:

- the expected number of image assets exists;
- each scene maps to its own image asset;
- no scene output is intentionally marked as a collage or storyboard;
- prompts do not contain unapproved subtitle-rendering instructions;
- required in-scene text is explicitly marked rather than inferred from narration.
