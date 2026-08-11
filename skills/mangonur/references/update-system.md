# Mangonur Local Update System

## Goal

Local Mangonur installations on Windows and macOS should update from a shared Google Drive release channel without executing the skill directly from Drive.

## Shared release layout

```text
<MANGONUR_WORKSPACE>/_system/skill/
  manifest.json
  releases/
    1.7.0/
      mangonur.zip
```

`manifest.json` contains the latest version, archive relative path and SHA-256 digest.

## Local layout

```text
<MANGONUR_SKILL_HOME>/
  current/
  versions/
    1.7.0/
  downloads/
  state.json
```

The updater:
1. reads the shared manifest;
2. compares semantic versions;
3. copies the release archive to a local staging path;
4. verifies SHA-256;
5. extracts into a version-specific staging folder;
6. verifies `mangonur/SKILL.md` exists;
7. promotes the version folder;
8. replaces `current` only after validation;
9. writes local state.

Never execute a half-synchronized archive. Never place API credentials in the release tree.

## Automatic behavior

The launcher should run the updater before starting a Mangonur local runtime or Remotion Studio. A failed update must not delete the last known-good installation.

## Runtime bootstrap contract (v1.8)

A ChatGPT-installed Mangonur skill may remain a stable bootstrap. When authorized Desktop Commander access is available, it should update the local runtime, read the refreshed local `SKILL.md` plus `runtime-requirements.json`, run `scripts/doctor.py`, and follow that local specification for the session. This allows later release requirements to evolve without requiring a fresh ChatGPT skill upload for every runtime revision.

Doctor is diagnostic. Repairs must be explicit, minimal, non-destructive, and limited to requirements declared by the current runtime. Optional heavy dependencies should remain worker-preferred unless the current release explicitly changes that policy.
