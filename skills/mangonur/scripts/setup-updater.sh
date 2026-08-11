#!/bin/sh
# Path: scripts/setup-updater.sh
# Summary: Configures the macOS/Linux machine-local Mangonur skill home and prints the shell export that should be persisted.
set -eu
SKILL_HOME="${1:?Usage: setup-updater.sh <skill-home>}"
mkdir -p "$SKILL_HOME/versions" "$SKILL_HOME/downloads"
printf 'export MANGONUR_SKILL_HOME=%s\n' "$(printf %s "$SKILL_HOME" | sed "s/'/'\\''/g")"
echo "Created $SKILL_HOME"
