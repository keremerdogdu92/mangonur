#!/bin/sh
# Path: scripts/launch-studio.sh
# Summary: Runs the Mangonur updater first, then starts Remotion Studio from a machine-local project folder on macOS/Linux.
set -eu
PROJECT_ID="${1:?Usage: launch-studio.sh <project-id>}"
: "${MANGONUR_SKILL_HOME:?MANGONUR_SKILL_HOME is required}"
: "${MANGONUR_LOCAL_WORKSPACE:?MANGONUR_LOCAL_WORKSPACE is required}"
UPDATER="$MANGONUR_SKILL_HOME/current/scripts/update-skill.sh"
[ ! -f "$UPDATER" ] || sh "$UPDATER"
PROJECT="$MANGONUR_LOCAL_WORKSPACE/projects/$PROJECT_ID/remotion"
[ -f "$PROJECT/package.json" ] || { echo "Remotion project not found: $PROJECT" >&2; exit 1; }
cd "$PROJECT"
exec npx remotion studio --no-open
