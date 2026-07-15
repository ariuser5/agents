#!/bin/sh

set -eu

SOURCE=$(CDPATH= cd "$(dirname "$0")" && pwd -P)
DESTINATION=${1:-"$HOME/.agents"}

mkdir -p "$DESTINATION"
cp "$SOURCE/global.md" "$DESTINATION/global.md"

for directory in rules skills adapters; do
    mkdir -p "$DESTINATION/$directory"
    cp -R "$SOURCE/$directory/." "$DESTINATION/$directory/"
done

printf 'Agent rules copied to %s\n' "$DESTINATION"
