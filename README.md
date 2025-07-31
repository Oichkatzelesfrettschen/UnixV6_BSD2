# UnixV6_BSD2
A chimera of legacy UNIX V6 and 2BSD: which they already were.

## Historical Context
This repository mirrors material distributed on the "Second Berkeley Software Tape" dated May 1979.  The tape combined Bell Labs' Sixth Edition UNIX with Berkeley's early BSD enhancements.  It includes sources, documents and prebuilt binaries for PDP-11 based systems and the then-new VAX.

The original `READ_ME.md` from the distribution is dated "Thu Apr 19 23:25:43 PST 1979" and is reproduced below for reference:

```
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
```

## Directory Layout
- **bin** – Precompiled binaries built on a standard Version 6 system.
- **doc** – Source of papers and assorted documentation.
- **man** – Manual page sources.
- **misc** – Miscellaneous utilities referenced by the installation notes.
- **src** – Program sources, including editors, shells and Pascal tools.  See `src/READ_ME` for details about each subdirectory.
- **upgrade** – Additional material for retrofitting Version 6 systems.
- **TAPE**, **tar**, **tarit**, **create**, **setup** – Scripts and notes used to create and extract the original distribution tape.

## Building and Usage
Detailed installation procedures are described in `install.ms` which can be formatted with:

```
nroff -ms install.ms | more
```

Where possible the provided Makefiles may be used.  On older Version 6 systems without `make`, use the accompanying `make.script` shell scripts.  Many programs assume the retrofit library located in `upgrade/libretro`, and some expect directories such as `/usr/ucb` and `/usr/msgs` to exist (see `setup`).  Prebuilt binaries in `bin` may be sufficient for a stock Version 6 UNIX.  Recompilation is recommended for modified systems or newer UNIX versions.

