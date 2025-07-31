#!/bin/sh
# harness.sh - simple shell-based test utilities
#
# Provides helpers for compiling minimal utilities and asserting
# expected output. Each test script may source this file.

set -e

ROOT_DIR=$(cd "$(dirname "$0")/.." && pwd)
TMP_DIR="$ROOT_DIR/tests/tmp"
mkdir -p "$TMP_DIR"

failures=0

# compile_utils util1 util2 ...
#   Compiles each src/<util>.c into build/<util>
compile_utils() {
    mkdir -p "$ROOT_DIR/build"
    CC=${CC:-gcc}
    CFLAGS=${CFLAGS:--Icompat -Wall -Wextra -O2}
    for u in "$@"; do
        $CC $CFLAGS "$ROOT_DIR/src/$u.c" -o "$ROOT_DIR/build/$u"
    done
}

# run_test test_script
#   Executes a test script and records failure
run_test() {
    sh "$1" || failures=$((failures + 1))
}

# assert_equal expected cmd...
#   Runs cmd and compares its output to expected string
assert_equal() {
    expected="$1"
    shift
    output="$("$@")"
    if [ "$output" != "$expected" ]; then
        echo "expected '$expected', got '$output'" >&2
        return 1
    fi
    return 0
}

finish() {
    if [ $failures -eq 0 ]; then
        echo "All tests passed."
    else
        echo "$failures tests failed." >&2
    fi
    return $failures
}
