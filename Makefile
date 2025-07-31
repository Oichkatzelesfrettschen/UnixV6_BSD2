# UnixV6_BSD2 top-level Makefile
#
# This file orchestrates the build of the historical sources in the
# `src` and `upgrade` trees.  Each subdirectory retains its original
# `makefile` describing how the tools were built on mid 1970s UNIX
# systems.  The rules below simply delegate to these makefiles while
# allowing the user to specify modern compilers and flags.
#
# Usage:
#   make            # build everything
#   make clean      # remove intermediate files in all subdirectories
#   make <dir>      # invoke make inside <dir>
#
# Variables that may be overridden on the command line:
#   CC     - C compiler to invoke (default: cc)
#   CFLAGS - Flags passed to the compiler (default: -O2 -pipe -std=c11)
#   MAKE   - Make program (default: make)
#
# Example:
#   make CC=clang CFLAGS="-O2 -Wall -std=c11"
#
# The historical makefiles expect a traditional V7 environment.  Many
# of the programs will compile with a modern compiler provided the
# above variables are set appropriately.  Some may require additional
# porting which is beyond the scope of this wrapper.

# Default tools
CC     ?= cc
CFLAGS ?= -O2 -pipe -std=c11
MAKE   ?= make

# Source subdirectories containing legacy makefiles
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

.PHONY: all clean $(SRC_SUBDIRS) $(UPGRADE_SUBDIRS)

# Build everything
all: $(SRC_SUBDIRS) $(UPGRADE_SUBDIRS)

# Delegate to each subdirectory's original makefile
$(SRC_SUBDIRS) $(UPGRADE_SUBDIRS):
	$(MAKE) -C $@ CC="$(CC)" CFLAGS="$(CFLAGS)"

# Clean all build artifacts
clean:
	@for d in $(SRC_SUBDIRS) $(UPGRADE_SUBDIRS); do \
	$(MAKE) -C $$d clean; \
	done
