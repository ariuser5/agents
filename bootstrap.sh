#!/bin/sh

set -eu

SOURCE=$(CDPATH= cd "$(dirname "$0")" && pwd -P)
DESTINATION=${1:-"$HOME/.agents"}
MANIFEST="$SOURCE/managed-files.txt"

if [ ! -f "$MANIFEST" ]; then
    printf 'Deployment allowlist is missing: %s\n' "$MANIFEST" >&2
    exit 1
fi
if [ -e "$DESTINATION" ] && [ ! -d "$DESTINATION" ]; then
    printf 'Destination exists but is not a directory: %s\n' "$DESTINATION" >&2
    exit 1
fi

has_files=false
while IFS= read -r relative_path || [ -n "$relative_path" ]; do
    if [ -z "$relative_path" ]; then
        continue
    fi
    case "$relative_path" in
        /*|*':'*|*'\'*|.|..|./*|../*|*/.|*/..|*/./*|*/../*|*//*)
            printf 'Unsafe deployment path in managed-files.txt: %s\n' "$relative_path" >&2
            exit 1
            ;;
    esac

    source_file="$SOURCE/$relative_path"
    target_file="$DESTINATION/$relative_path"
    if [ ! -f "$source_file" ]; then
        printf 'Managed source file is missing: %s\n' "$source_file" >&2
        exit 1
    fi
    if [ -d "$target_file" ]; then
        printf 'A directory blocks a managed file target: %s\n' "$target_file" >&2
        exit 1
    fi
    has_files=true
done < "$MANIFEST"

if [ "$has_files" = false ]; then
    printf 'Deployment allowlist is empty: %s\n' "$MANIFEST" >&2
    exit 1
fi

while IFS= read -r relative_path || [ -n "$relative_path" ]; do
    if [ -z "$relative_path" ]; then
        continue
    fi
    target_file="$DESTINATION/$relative_path"
    mkdir -p "$(dirname "$target_file")"
    cp "$SOURCE/$relative_path" "$target_file"
done < "$MANIFEST"

printf 'Agent library deployment completed for %s.\n' "$DESTINATION"
printf 'Unlisted files and product configuration were left untouched.\n'
