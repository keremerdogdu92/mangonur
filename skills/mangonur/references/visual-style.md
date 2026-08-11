# Mangonur Visual Style

## Default visual language

Unless the user defines a different style for a specific video, use this recurring Mangonur visual identity:

Clean polished 2D cartoon editorial illustration, chibi-inspired historical or narrative characters, large expressive heads with small stylized bodies, thick clean black outlines, flat vibrant colors, restrained simple shading, expressive but not childish, educational-history editorial aesthetic, clean readable silhouettes, cinematic but uncluttered composition, vertical 9:16.

This is the base style, not the entire scene prompt.

## Continuity rules

Across all scenes, maintain:

- recurring character facial identity;
- hair shape and color;
- skin tone;
- clothing design;
- uniforms and insignia;
- prop design;
- architecture;
- cultural setting;
- time period;
- color logic;
- illustration rendering style.

When a historical figure appears repeatedly, define a compact reusable character description and repeat the important identity traits in every independent image prompt.

Do not rely on phrases like "same person as previous image" in a standalone text prompt.

## Historical and cultural accuracy

Before producing prompts:

- verify flags;
- verify clothing and uniforms when they matter;
- verify architecture;
- avoid importing visual symbols from the wrong country or empire;
- distinguish culturally similar regions when the distinction is important;
- do not use modern objects in historical scenes unless intentional.

When exact detail is uncertain, prefer a historically plausible neutral treatment over a confident false detail.

## Composition

Default:
- vertical 9:16;
- strong central storytelling;
- mobile-readable silhouettes;
- one dominant action per frame;
- exactly one standalone scene / visual beat per image;
- never combine scenes into a collage, storyboard grid, contact sheet, split-screen, comparison sheet, character sheet, or multi-panel composition;
- narration, subtitle, caption, dialogue, and script wording are context only and must not be rendered into the image unless the scene explicitly requires visible in-world text;
- batch generation must produce separate image outputs, not a combined multi-scene canvas;
- avoid excessive tiny background detail;
- reserve a clean caption-safe area covering the upper 20-25% of the frame;
- do not place faces, text, clocks, flags, or other important storytelling objects inside that caption-safe area.

Caption-safe area is mandatory for standard Mangonur vertical video scenes unless the user explicitly requests a different caption layout. If the upper 20-25% must contain an essential visual element for a specific scene, explicitly move the caption-safe area to another clearly empty region and state that choice in the prompt.

Use:
- wide shot for geography, scale, or group action;
- medium shot for interaction;
- close-up for reaction, reveal, or object detail;
- occasional dramatic perspective for escalation.

Do not use the same framing repeatedly.

## Prompt construction order

A strong scene prompt should normally describe:

1. format and style;
2. location and period;
3. main subject identity;
4. action;
5. expression/body language;
6. supporting characters or objects;
7. architecture/environment;
8. composition/camera;
9. lighting/mood;
10. continuity constraints;
11. exclusions;
12. caption-space requirement.

## Default exclusions

Use only when relevant:

- no text;
- no watermark;
- no logos unless historically required;
- no modern clothing;
- no modern technology;
- no incorrect national symbols;
- no unrelated Ottoman/Turkish imagery when the scene is not Ottoman/Turkish;
- no extra fingers or duplicated limbs;
- no graphic gore;
- no photorealism when using the recurring cartoon identity.

Avoid bloating every prompt with exclusions that have no connection to the scene.

## Death and violence

For death:
- use symbolic, respectful, non-graphic representation;
- portraits, covered resting places, empty thrones, mourning attendants, damaged objects, smoke, aftermath, silhouettes, or reaction shots can communicate the event.

For combat:
- focus on readable action and story;
- graphic injury is usually unnecessary for Mangonur's style.

## Prompt independence

Every final image prompt should be usable by itself.

If an external reference image will be attached, explicitly say what that reference controls:
- character identity;
- outfit;
- visual style;
- location layout.

Otherwise restate the required features in text.
