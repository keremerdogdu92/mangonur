#!/bin/sh
# Path: scripts/launch-tools-panel.sh
# Summary: Starts the loopback-only Mangonur Audio & Finishing panel for a local macOS/Linux project after validating workspace paths.
set -eu
PROJECT_ID="${1:?Usage: launch-tools-panel.sh <project-id>}"
: "${MANGONUR_LOCAL_WORKSPACE:?MANGONUR_LOCAL_WORKSPACE is required}"
: "${MANGONUR_SKILL_HOME:?MANGONUR_SKILL_HOME is required}"
PROJECT_ROOT="$MANGONUR_LOCAL_WORKSPACE/projects/$PROJECT_ID"
[ -d "$PROJECT_ROOT" ] || { echo "Project not found: $PROJECT_ROOT" >&2; exit 1; }
SERVER="$MANGONUR_SKILL_HOME/current/templates/tools-panel/server.mjs"
[ -f "$SERVER" ] || { echo "Mangonur tools server not found: $SERVER" >&2; exit 1; }
export MANGONUR_PROJECT_ROOT="$PROJECT_ROOT"
exec node "$SERVER"
