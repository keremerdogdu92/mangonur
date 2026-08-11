# Mangonur Shared Workspace

## Purpose

Mangonur uses a two-root workspace so multiple editors can share durable project assets without forcing Remotion, Node.js, caches, or temporary renders to execute inside Google Drive.

## Required environment variables

- `MANGONUR_WORKSPACE`: shared Google Drive root. This is the durable source of truth.
- `MANGONUR_LOCAL_WORKSPACE`: machine-local high-speed working root.

Never hard-code drive letters. Resolve these variables at runtime.

## Shared root layout

```text
<MANGONUR_WORKSPACE>/
  library/
    sfx/
    music/
    metadata/
  projects/
    <project-id>/
      script/
      visuals/
      narration/
      alignment/
      audio_candidates/
      audio_selected/
      manifests/
      renders/
        review/
        final/
  _incoming/
  _exports/
  _system/
```

## Local root layout

```text
<MANGONUR_LOCAL_WORKSPACE>/
  projects/<project-id>/
    remotion/
    working/
    temp/
    cache/
  shared-cache/
```

`node_modules`, Remotion caches, temporary frames, browser caches, generated proxies, and disposable intermediate files are local-only.

## Project identity

Use a stable project ID such as `2026-08-10-shortest-war`. Do not create two differently named folders for the same video. Store durable project state in `manifests/project.json`.

## Asset flow

1. Reusable SFX/music are first checked in `library/`.
2. New candidate audio may be downloaded/generated locally for audition.
3. Candidate metadata is recorded in the project manifest.
4. Only approved reusable assets are promoted into `library/`; project-specific approved files live in `audio_selected/`.
5. Remotion works from the local project copy.
6. Review renders are copied to `renders/review/`.
7. Final delivery renders are copied to `renders/final/` using versioned names. Never overwrite a final file silently.

## Conflict rules

- Treat shared manifests as durable state, not a high-frequency scratchpad.
- Avoid simultaneous edits to the same manifest from two computers.
- Use versioned render names such as `review-v03.mp4` and `final-v02.mp4`.
- Never store secrets, API keys, cookies, or tokens in the shared workspace.

## Offline availability

For active projects, prefer Drive files marked available offline before assembly. Do not render directly against cloud-only placeholder files.


## Lightweight collaboration metadata (v1.6)

Mangonur supports sequential collaboration without pretending Google Drive is a real-time database.

Each durable project manifest should include:

```json
{
  "revision": 1,
  "lastEditedBy": "kerem",
  "lastEditedAt": "2026-08-10T21:41:00+03:00"
}
```

For now, use advisory edit-session metadata only when useful. Do not build high-frequency real-time locking on Drive. If two editors need the same project, prefer sequential handoff or editing separate scene/audio scopes. A future multi-user layer may replace this with stronger locking or a database-backed collaboration service.
