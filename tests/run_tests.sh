#!/bin/sh
set -e
# compile and run tests
DIR=$(cd "$(dirname "$0")/.." && pwd)
cd "$DIR"

mkdir -p build
CC=${CC:-gcc}
CFLAGS="-Icompat -Wall -Wextra -O2"

UTILS="whoami head expand printenv"
for u in $UTILS; do
    $CC $CFLAGS src/$u.c -o build/$u
done

mkdir -p tests/tmp
fail=0

# whoami
expected=$(id -un)
output=$(build/whoami)
[ "$output" = "$expected" ] || { echo "whoami failed: $output"; fail=1; }

# head
printf "a\nb\nc\n" >tests/tmp/file
build/head -2 tests/tmp/file >tests/tmp/out
printf "a\nb\n" >tests/tmp/expected
if ! diff -u tests/tmp/expected tests/tmp/out; then
    echo "head failed"; fail=1
fi

# expand
printf "a\tb\n" >tests/tmp/tabs
build/expand tests/tmp/tabs >tests/tmp/out
printf "a       b\n" >tests/tmp/expected
if ! diff -u tests/tmp/expected tests/tmp/out; then
    echo "expand failed"; fail=1
fi

# printenv
build/printenv PATH >tests/tmp/out
if ! [ -s tests/tmp/out ]; then
    echo "printenv failed"; fail=1
fi

if [ $fail -eq 0 ]; then
    echo "All tests passed."
else
    echo "Some tests failed." >&2
fi
exit $fail
