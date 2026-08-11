#!/bin/sh
# Path: scripts/update-skill.sh
# Summary: Updates a macOS/Linux local Mangonur skill installation from the shared Drive release channel with SHA-256 verification.
set -eu
: "${MANGONUR_WORKSPACE:?MANGONUR_WORKSPACE is required}"
: "${MANGONUR_SKILL_HOME:?MANGONUR_SKILL_HOME is required}"
CHANNEL="$MANGONUR_WORKSPACE/_system/skill"
MANIFEST="$CHANNEL/manifest.json"
[ -f "$MANIFEST" ] || { echo "Release manifest not found: $MANIFEST" >&2; exit 1; }
LATEST=$(python3 -c 'import json,sys; print(json.load(open(sys.argv[1],encoding="utf-8-sig"))["latestVersion"])' "$MANIFEST")
ARCHIVE=$(python3 -c 'import json,sys; print(json.load(open(sys.argv[1],encoding="utf-8-sig"))["archive"])' "$MANIFEST")
EXPECTED=$(python3 -c 'import json,sys; print(json.load(open(sys.argv[1],encoding="utf-8-sig"))["sha256"].lower())' "$MANIFEST")
STATE="$MANGONUR_SKILL_HOME/state.json"
CURRENT=""
[ ! -f "$STATE" ] || CURRENT=$(python3 -c 'import json,sys; print(json.load(open(sys.argv[1],encoding="utf-8-sig")).get("version",""))' "$STATE")
[ "${1:-}" = "--force" ] || [ "$CURRENT" != "$LATEST" ] || { echo "Mangonur is current: $CURRENT"; exit 0; }
SOURCE="$CHANNEL/$ARCHIVE"
[ -f "$SOURCE" ] || { echo "Release archive not available locally yet: $SOURCE" >&2; exit 1; }
mkdir -p "$MANGONUR_SKILL_HOME/downloads" "$MANGONUR_SKILL_HOME/versions"
LOCAL="$MANGONUR_SKILL_HOME/downloads/mangonur-$LATEST.zip"
cp "$SOURCE" "$LOCAL"
ACTUAL=$(shasum -a 256 "$LOCAL" | awk '{print tolower($1)}')
[ "$ACTUAL" = "$EXPECTED" ] || { echo 'Release SHA-256 verification failed.' >&2; exit 1; }
STAGE="$MANGONUR_SKILL_HOME/versions/.staging-$LATEST-$$"
rm -rf "$STAGE" && mkdir -p "$STAGE"
unzip -q "$LOCAL" -d "$STAGE"
[ -f "$STAGE/mangonur/SKILL.md" ] || { rm -rf "$STAGE"; echo 'Release archive is missing mangonur/SKILL.md.' >&2; exit 1; }
VERSION="$MANGONUR_SKILL_HOME/versions/$LATEST"
rm -rf "$VERSION" && mv "$STAGE" "$VERSION"
rm -rf "$MANGONUR_SKILL_HOME/previous"
[ ! -d "$MANGONUR_SKILL_HOME/current" ] || mv "$MANGONUR_SKILL_HOME/current" "$MANGONUR_SKILL_HOME/previous"
cp -R "$VERSION/mangonur" "$MANGONUR_SKILL_HOME/current"
python3 - "$STATE" "$LATEST" <<'PY2'
import json,sys,datetime
with open(sys.argv[1],'w') as f: json.dump({'version':sys.argv[2],'updatedAt':datetime.datetime.now().astimezone().isoformat()},f,indent=2)
PY2
echo "Mangonur updated to $LATEST"
