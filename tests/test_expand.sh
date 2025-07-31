#!/bin/sh
. "$(dirname "$0")/harness.sh"

printf 'a\tb\n' > "$TMP_DIR/tabs"
"$ROOT_DIR/build/expand" "$TMP_DIR/tabs" > "$TMP_DIR/out"
printf 'a       b\n' > "$TMP_DIR/exp"
if ! diff -u "$TMP_DIR/exp" "$TMP_DIR/out"; then
    exit 1
fi
