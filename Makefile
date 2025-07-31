CC=gcc
CFLAGS=-Icompat -Wall -Wextra -O2
UTILS=whoami head expand printenv

build: $(UTILS:%=build/%)

build/%: src/%.c compat/retrofit.h
	@mkdir -p build
	$(CC) $(CFLAGS) $< -o $@

test: build
	./tests/run_tests.sh

clean:
	rm -rf build tests/tmp

.PHONY: build test clean
