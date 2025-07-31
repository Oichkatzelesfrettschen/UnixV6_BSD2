# UnixV6_BSD2 top-level Makefile
#
# Orchestrates:
#  1) legacy “src” and “upgrade” subdirs (each with original 1970s-style Makefiles)
#  2) a small set of modern utilities under src/%.c, built into build/
#  3) a test harness for those utilities

#————————————————————————————————————————————————————
# User‐overrideable tool settings
CC     ?= cc
CFLAGS ?= -O2 -pipe -std=c11
MAKE   ?= make

#————————————————————————————————————————————————————
# Legacy source subtrees
SRC_SUBDIRS = \
  src \
  src/termlib \
  src/Mail \
  src/csh \
  src/ex \
  src/eyacc \
  src/libNS \
  src/me \
  src/net \
  src/pascal \
  src/pi \
  src/pi0 \
  src/pi1 \
  src/px \
  src/pxp \
  src/pxref

UPGRADE_SUBDIRS = \
  upgrade/libretro \
  upgrade/src

#————————————————————————————————————————————————————
# “Modern” utilities to compile via src/%.c
UTILS = whoami head expand printenv

#————————————————————————————————————————————————————
.PHONY: all legacy utils build test clean $(SRC_SUBDIRS) $(UPGRADE_SUBDIRS)

all: legacy utils

# 1) Build the legacy trees
legacy: $(SRC_SUBDIRS) $(UPGRADE_SUBDIRS)

$(SRC_SUBDIRS) $(UPGRADE_SUBDIRS):
	$(MAKE) -C $@ CC="$(CC)" CFLAGS="$(CFLAGS)"

#————————————————————————————————————————————————————
# 2) Build the small utilities
build:
	@mkdir -p build

utils: build $(UTILS:%=build/%)

build/%: src/%.c compat/retrofit.h
	$(CC) $(CFLAGS) $< -o $@

#————————————————————————————————————————————————————
# 3) Run the utility test suite
test: utils
	./tests/run_tests.sh

#————————————————————————————————————————————————————
# Cleanup everything
clean:
	@for d in $(SRC_SUBDIRS) $(UPGRADE_SUBDIRS); do \
	  $(MAKE) -C $$d clean; \
	done
	rm -rf build tests/tmp