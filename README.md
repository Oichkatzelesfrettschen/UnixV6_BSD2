# UnixV6_BSD2
A chimera of legacy Unix v6 and 2BSD: which they already were.

## Building on a modern system

The repository now includes a top‑level `Makefile` that delegates to the
original makefiles found throughout `src` and `upgrade`.  These historic
makefiles were written for Version 7 UNIX and expect the traditional tools
(`cc`, `as`, `ar`, `ed`, …).  When compiling today you can override the
compiler and flags used by specifying `CC` and `CFLAGS` on the command line.

Typical invocation with a modern compiler:

```sh
make CC=clang CFLAGS="-O2 -pipe -std=c11"
```

The default settings use `cc` and pass `-O2 -pipe -std=c11`.  Some
subdirectories may require additional work to build outside of an historic
environment.
