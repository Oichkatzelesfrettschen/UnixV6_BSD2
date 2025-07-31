#!/bin/sh
. "$(dirname "$0")/harness.sh"

"$ROOT_DIR/build/printenv" PATH > "$TMP_DIR/out"
[ -s "$TMP_DIR/out" ]
