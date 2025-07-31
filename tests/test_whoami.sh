#!/bin/sh
. "$(dirname "$0")/harness.sh"

expected=$(id -un)
assert_equal "$expected" "$ROOT_DIR/build/whoami"
