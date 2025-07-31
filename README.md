# UnixV6_BSD2

> A chimera of legacy Unix Version 6 and 2-Clause BSD: which they already were.

---

## Overview

This repository brings together:

1. **Original Unix V6 sources** (circa 1975), released under the historic **4-Clause BSD** license by the Regents of the University of California.  
2. **All subsequent modifications and modern glue** (scripts, CI, small utilities), released under the **2-Clause (“Simplified”) BSD** license.

We preserve the spirit—and legal heritage—of Berkeley Unix, while adding a reproducible, multi-profile build system and friendly documentation.

---

## Prerequisites

- A POSIX-compatible shell (e.g. bash, zsh)  
- A C compiler toolchain supporting C11 (e.g. `cc`, `gcc`, or `clang`)  
- GNU `make` (or compatible)  
- Standard UNIX utilities (`ar`, `as`, `ld`, `ed`, …)  
- (Optional) Python 3 for the test harness  
- (Optional) `build.sh` helper uses `bash` features  

---

## Build

We offer **two** top-level build entrypoints:

### 1. `build.sh` profiles

```sh
# Developer build (default, with debug symbols + warnings)
./build.sh

# High-performance build (optimized)
./build.sh -p performance

# Release build (stripped, O2)
./build.sh -p release