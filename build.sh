#!/usr/bin/env bash
# build.sh - iterate through subdirectory makefiles with selectable profiles
#
# Usage: ./build.sh [-p PROFILE]
#
# Profiles:
#   developer    -O0 -g -Wall (default)
#   performance  -O2 -pipe -march=native -Wall
#   release      -O2 -pipe -march=native -DNDEBUG -Wall -s
#
# The script searches the `src/` and `upgrade/` trees for any Makefile and
# invokes `make` within each directory using the profile's CFLAGS.
#
# Example:
#   ./build.sh                # developer profile
#   ./build.sh -p performance # tuned build
#   ./build.sh -p release     # production build
#
set -e

profile=developer

usage() {
    sed -n '2,16p' "$0"
}

while [ $# -gt 0 ]; do
    case "$1" in
        -p|--profile)
            profile="$2"; shift 2;;
        -h|--help)
            usage; exit 0;;
        *)
            echo "Unknown option: $1" >&2
            usage; exit 1;;
    esac
done

case "$profile" in
    developer)
        CFLAGS="-O0 -g -Wall";;
    performance)
        CFLAGS="-O2 -pipe -march=native -Wall";;
    release)
        CFLAGS="-O2 -pipe -march=native -DNDEBUG -Wall -s";;
    *)
        echo "Invalid profile: $profile" >&2
        exit 1;;
esac

echo "Using profile '$profile' (CFLAGS='$CFLAGS')"

# Collect directories containing Makefiles under src/ and upgrade/
find src upgrade -type f -iname 'makefile*' -printf '%h\n' | sort -u |
while read -r dir; do
    echo "=== Building $dir ==="
    make -C "$dir" CFLAGS="$CFLAGS"
done

