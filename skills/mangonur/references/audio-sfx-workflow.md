# Mangonur Audio / SFX Selection Workflow

## Principle
Narration is the master. SFX and music support comprehension and rhythm; they must not fight the voice.

## Workspace resolution
Resolve `MANGONUR_WORKSPACE` and `MANGONUR_LOCAL_WORKSPACE` first. Search the shared `library/sfx` and `library/music` before downloading or generating new material. Reuse an existing approved asset when it fits the slot and its metadata permits reuse.

## Discovery
For each scene, decide whether sound adds value. Avoid filling every cut with an effect. Typical slots: impact/reveal, movement/transition, ambience, object/action, comedic accent, climax, outro.

For each useful slot, research 3-4 distinct candidates with clear licensing/usage suitability. When local-computer tools are available, download audition copies into the shared project candidate folder such as `<MANGONUR_WORKSPACE>/projects/<project-id>/audio_candidates/01_hook/A.wav`, `B.wav`, `C.wav`. Keep source/license metadata in `audio_candidates/manifest.json`. Do not save API keys or private credentials in metadata.

Background music is a separate selection slot and follows the same A/B/C workflow. Prefer instrumental beds without busy vocals.

## User audition gate
Tell the user what each slot is for and which local files to play. Wait for choices like `1C 2A 3B MUSIC-B`. Rejected slots receive a new candidate batch without disturbing approved slots.

## Lock and assembly
Copy selected files into the shared project `audio_selected/` folder with semantic names. If an approved asset is broadly reusable, also promote a canonical copy into the appropriate shared `library/` category and preserve its metadata. Remotion places them on the timeline. Do not time-stretch SFX unless explicitly needed; trim/fade instead. Duck background music under narration and major SFX.

## Quality rules
- speech always wins;
- use fewer, recognizable effects rather than many generic 1-second sounds;
- avoid repetitive whooshes on every cut;
- match historical/cultural context where material;
- no unverified copyrighted commercial music;
- retain source/license metadata for every external asset.
