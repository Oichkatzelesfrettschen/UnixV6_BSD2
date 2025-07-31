# Building Legacy Binaries

This repository contains source code for historical Unix utilities.
Prebuilt binaries have been removed from version control. To recreate
these executables you need a cross toolchain capable of targeting the
PDP-11 architecture. The examples below assume the tools are available
as `pdp11-aout-gcc`, `pdp11-aout-as` and `pdp11-aout-ar`.

## Prerequisites

1. Install a PDP-11 cross compiler (for example the [pdp11-gcc project](https://github.com/PDClib/pdp11-gcc)).
2. Ensure the cross tools are in your `PATH` or set the environment variables
   `PDP11_CC`, `PDP11_AS` and `PDP11_AR` to point at them.

## Building All Binaries

Run the convenience script:

```bash
./scripts/build_binaries.sh
```

This script compiles all removed binaries, including the retrofit library
objects, Pascal support files and example programs. If `src/tar.c` is not
present the script skips rebuilding `tar` and emits a warning.

## Manual Build

The build script simply automates the following commands:

```bash
# csfix and ar
$PDP11_CC -O doc/pascal/csfix.c -o doc/pascal/csfix -lS
$PDP11_CC -O misc/ar.c -o misc/ar

# Pascal runtime and header
(cd src/pascal/assubs && $PDP11_AS -o fcrt0 fcrt0.s)
(cd src/pascal && $PDP11_CC -O px_header.c -o px_header && dd if=px_header of=px_header bs=1b conv=sync)
# The dd step pads `px_header` to a 512-byte boundary as required by the
# PDP-11 toolchain.
(cd src/pascal/opcodes && $PDP11_CC -O -c TRdata.c)

# Retrofit library objects
(cd upgrade/libretro && make clean && make CC=$PDP11_CC AS=$PDP11_AS AR=$PDP11_AR)

# Sample profile output
$PDP11_CC -O src/pxp/pmon.c -o doc/pascal/pmon.out
```

Refer to the individual makefiles under `doc/` and `upgrade/` for
additional targets.
