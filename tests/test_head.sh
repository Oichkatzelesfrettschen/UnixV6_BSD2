#!/bin/sh
. "$(dirname "$0")/harness.sh"

printf 'a\nb\nc\n' > "$TMP_DIR/in"
"$ROOT_DIR/build/head" -2 "$TMP_DIR/in" > "$TMP_DIR/out"
printf 'a\nb\n' > "$TMP_DIR/exp"
if ! diff -u "$TMP_DIR/exp" "$TMP_DIR/out"; then
    exit 1
fi
