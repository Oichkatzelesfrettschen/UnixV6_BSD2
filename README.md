# UnixV6_BSD2

> A chimera of legacy Unix v6 and 2BSD: which they already were.

---

## Overview

This repository brings together the original **Unix Version 6** sources (1975) under the historic 4-Clause BSD license and all subsequent modifications under the modern 2-Clause BSD license, preserving both the spirit and the legal heritage of Berkeley Unix.

---

## Build

We provide a helper script to walk through the many historic Makefiles and build everything in one go:

```sh
# Default (developer) build, with debugging CFLAGS
./build.sh

# Optimized for performance
./build.sh -p performance

# Release-style (stripped, O2)
./build.sh -p release

Each profile adjusts CFLAGS (you can inspect build.sh for details).

⸻

Installation

See the step-by-step guide in docs/INSTALL.md.

⸻

Usage

Basic examples, command-line flags, and workflow tips are in docs/USAGE.md.

⸻

Documentation
	•	Installation instructions: docs/INSTALL.md
	•	Usage basics: docs/USAGE.md
	•	Modernized manuals: man/
	•	Original troff sources: legacy/

⸻

License

This project is dual-licensed:
	1.	Original Unix v6 code (1979)
Released under the 4-Clause BSD License by The Regents of the University of California.
	2.	All subsequent changes and additions
Released under the 2-Clause (“Simplified”) BSD License.

See LICENSE for the full text of both the 4-Clause and 2-Clause BSD licenses.

⸻


