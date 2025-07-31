#!/bin/sh
# build.sh - Compile all project components using existing makefiles.
#
# Usage: ./build.sh [-p PROFILE]
#   PROFILE can be one of the following:
#       developer  - Debug build with no optimizations.
#       performance- Optimized build for development testing.
#       release    - Fully optimized build stripped of symbols.
# The default profile is 'developer'.

set -e

profile=developer

while [ $# -gt 0 ]; do
    case "$1" in
        -p|--profile)
            profile="$2"
            shift 2
            ;;
        -h|--help)
            sed -n '2,10p' "$0"
            exit 0
            ;;
        *)
            echo "Unknown option: $1" >&2
            sed -n '2,10p' "$0"
            exit 1
            ;;
    esac
done

case "$profile" in
    developer)
        CFLAGS="-O0 -g" ;;
    performance)
        CFLAGS="-O2 -march=native" ;;
    release)
        CFLAGS="-O2 -march=native -s" ;;
    *)
        echo "Invalid profile: $profile" >&2
        exit 1
        ;;
esac

printf 'Using profile %s (CFLAGS=%s)\n' "$profile" "$CFLAGS"

# Find all directories that contain a makefile and build them.
find . -type f -iname "makefile*" -exec dirname {} \; | sort -u | while read -r dir; do
    (cd "$dir" && make CFLAGS="$CFLAGS")
    if [ $? -ne 0 ]; then
        echo "=== Failed to build $dir ===" >&2
    else
        echo "=== Done $dir ==="
    fi
done
