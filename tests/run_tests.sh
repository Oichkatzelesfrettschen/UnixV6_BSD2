#!/bin/sh
set -e

DIR=$(cd "$(dirname "$0")/.." && pwd)
. "$DIR/tests/harness.sh"

compile_utils whoami head expand printenv

for t in "$DIR"/tests/test_*.sh; do
    echo "Running $(basename "$t")"
    run_test "$t"
done

finish
exit $?
