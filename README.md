# UnixV6_BSD2

> A chimera of legacy Unix Version 6 and 2-Clause BSD: which they already were.

---

## Historical Context

This repository mirrors the material distributed on the **Second Berkeley Software Tape** (May 1979), which combined Bell Labs’ Sixth Edition UNIX with Berkeley’s early BSD enhancements.  It includes sources, documents and prebuilt binaries for PDP-11 and VAX systems.

Below is the **original** `READ_ME.md` header from April 19 1979:

```text
Thu Apr 19 23:25:43 PST 1979

For installation instructions:

        nroff -ms install.ms

Subdirectories:
        bin             Binaries for standard version 6 systems
        doc             Source for documents
        man             Source for manual pages
        misc            A few miscellaneous files (see install.ms)
        src             Source for programs/troff macros
        upgrade         doc/man/src/include for version 6 systems


⸻

Directory Layout

.
├── bin/       Prebuilt UNIX V6 binaries for PDP-11
├── doc/       Troff sources for installation notes & papers
├── man/       Troff sources for manual pages
├── misc/      Miscellaneous files referenced by install scripts
├── src/       Program sources (shells, editors, Pascal tools, …)
├── upgrade/   Retrofit support library & headers for V6 systems
├── TAPE, tar, tarit, create, setup
│             Original scripts for tape creation and extraction
├── compat/    Small headers/stubs for building on a modern toolchain
├── build.sh   Multi-profile build helper
├── Makefile   Top-level Makefile wrapper for all legacy subdirs
├── docs/      Modern docs: INSTALL.md, USAGE.md
├── man/       Modernized man pages
├── legacy/    Raw troff archives from the historic tape
├── tests/     Test harness for tiny utilities
└── LICENSE    Dual-BSD licensing text


⸻

Overview of This Fork
	1.	Original Unix V6 code (circa 1975) — remains under the 4-Clause BSD license (Regents of the University of California, 1979).
	2.	All modern additions (build helpers, small utilities, CI, docs) — under the 2-Clause (“Simplified”) BSD license.

We preserve the original sources untouched, and layer on a reproducible, multi-profile build system plus friendly documentation.

⸻

Prerequisites
	•	POSIX-compatible shell (bash, zsh, …)
	•	C compiler (supports C11): cc, gcc, or clang
	•	GNU make (or compatible)
	•	Standard UNIX tools: ar, as, ld, ed, nroff, …
	•	(Optional) Python 3 for the test harness in tests/
	•	(Optional) QEMU or Bochs to run the assembled disk images

⸻

Building

1. Legacy-Makefile Wrapper

A top-level Makefile delegates into every historic subdirectory:

# Build everything with default compiler + flags:
make

# Override compiler or flags:
make CC=clang CFLAGS="-O2 -pipe -std=c11"

# Clean all legacy builds:
make clean

By default:

CC=cc
CFLAGS="-O2 -pipe -std=c11"

Many of the subdirectories still contain their original makefile written for V7 UNIX.  Some may need small tweaks or the presence of ed/ar on your PATH.

⸻

2. Modern build.sh Profiles

For an even simpler one-command build, use our Bash helper:

# Developer build (debug symbols + warnings)
./build.sh

# Performance-tuned build
./build.sh -p performance

# Release-style build (O2, stripped)
./build.sh -p release


Inspect `build.sh` to see which CFLAGS each profile applies.

### Rebuilding removed binaries

Historical archives and executables, such as `upgrade/libretro/libretro.a`, are
no longer tracked in Git.  Run the helper script to regenerate them with your
PDP‑11 cross compiler:

```bash
./scripts/build_binaries.sh
```

You may also invoke `make` directly inside `upgrade/libretro` for just the
retrofit library.

⸻

3. Tiny “compat” Utilities

We include a few single-file utilities (e.g. whoami, head, expand) in src/.  They compile into build/:

make utils    # builds each src/*.c → build/
make test     # runs ./tests/run_tests.sh


⸻

Installation & Usage
	1.	Format the installation notes and follow them:

nroff -ms install.ms | more


	2.	Install binaries to your UNIX V6 target (or emulator disk image).
	3.	Run under QEMU:

# assuming fs.img and xv6.img were produced:
qemu-system-i386 -serial mon:stdio \
  -drive file=fs.img,index=1,format=raw \
  -drive file=xv6.img,index=0,format=raw \
  -smp 2 -m 512



Detailed, step-by-step instructions are in docs/INSTALL.md; runtime tips are in docs/USAGE.md.

⸻

Documentation
	•	docs/INSTALL.md — Installation guide
	•	docs/USAGE.md   — Running & testing tips
	•	man/             — Modernized manual pages (HTML/PDF)
	•	legacy/          — Raw troff archives from the original tape

⸻

License

Dual-licensed—choose one:
	1.	4-Clause BSD (Regents of the University of California, 1979)
	2.	2-Clause BSD (“Simplified BSD”)

See LICENSE for the full text of both licenses.

⸻

Contributing
	•	Bug-fixes & docs under the 2-Clause BSD terms.
	•	Please follow the existing style, and add yourself to CONTRIBUTORS.md for non-trivial changes.
	•	Keep the original V6 sources unchanged; new code belongs in compat/, tests/, docs/, or src/ utilities.

⸻

Enjoy a deep dive into UNIX history—on your modern workstation!

