#!/usr/bin/env bash
# Build legacy PDP-11 binaries from source.
# Requires a cross toolchain providing pdp11-aout-gcc and pdp11-aout-as.
set -euo pipefail

CC=${PDP11_CC:-pdp11-aout-gcc}
AS=${PDP11_AS:-pdp11-aout-as}
AR=${PDP11_AR:-pdp11-aout-ar}

# Build csfix
${CC} -O doc/pascal/csfix.c -o doc/pascal/csfix

# Build ar
${CC} -O misc/ar.c -o misc/ar

# Build Pascal runtime pieces
( cd src/pascal/assubs && ${AS} -o fcrt0 fcrt0.s )

# Build Pascal header
( cd src/pascal && ${CC} -O px_header.c -o px_header && dd if=px_header of=px_header.tmp bs=1b conv=sync && mv px_header.tmp px_header )

# Build opcode data object
( cd src/pascal/opcodes && ${CC} -O -c TRdata.c )

# Build libretro objects
( cd upgrade/libretro && make clean && make CC=${CC} AS=${AS} AR=${AR} )

# Build pmon.out sample
${CC} -O src/pxp/pmon.c -o doc/pascal/pmon.out

# Build tar (source not included, placeholder)
if [ -f src/tar.c ]; then
  ${CC} -O src/tar.c -o src/tar
  cp src/tar ./tar
else
  echo "tar source unavailable. Please provide src/tar.c" >&2
fi

