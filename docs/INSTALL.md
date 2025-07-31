# Installation Guide

This document summarizes the historical instructions found in `install.ms` for installing the BSD2 software on a UNIX V6 or V7 system. The original troff file has extensive detail; the key steps are collected here.

## Requirements
* A UNIX V6 or V7 system with approximately 12,000 free disk blocks
* 800 BPI tape drive for the distribution tape

## Extracting the Tape
If your tape was written with `tar` or `cpio`, extract as usual. If it was written with `tp`, run:

```sh
tp xm ./create
sh create
tp xm
```

This creates the directory skeleton. Each directory contains a `cont.a` archive. Unpack these with:

```sh
ar x cont.a
rm cont.a # optional
```

## Installation Procedure
1. Run the `setup` script in the top directory to create required files and directories.
2. For version 6 systems run `upgrade/include/install` to install retrofit headers in `/usr/include/retrofit`.
3. Standard V6 systems may then run `bin/install` and skip to step 6.
4. On non‑standard V6 systems:
   1. Adjust and build `upgrade/libretro`, then install the library.
   2. Recompile `src/termlib` using `makefile.v6` (or `make.script`) and run `make install`.
   3. Recompile programs in `upgrade/src` with `make.script` or `makefile`.
   4. Follow the version 7 compilation instructions using `makefile.v6` or `make.script` whenever available.
5. On version 7 systems:
   1. Run `make` in `src/termlib` first (important library).
   2. In `src` and each subdirectory run `make` and `make install`. A good order is `Mail`, `csh`, `ex`, `me`. Use `make -n` to preview actions.
   3. Build the Pascal system; some parts require special handling on V7. See `misc/v7pascal` for details.
   4. Prepare `pascal`, `pi`, `px` and `pxp`. Systems without hardware floating point should use `pi0`, `pi1`, `px34` and `pxp34`.
6. Copy manual pages from `man` to `/usr/man/man*`. On V6 follow `upgrade/man` for macro differences.
7. Add `/usr/lib/ex2.0preserve -a` to `/etc/rc` before the temporary-file cleanup.
8. Modify your mail program so that messages to `msgs` run `/usr/ucb/msgs -s`. A sample V6 implementation is `misc/mail.c`.
9. Ensure `/usr/lib/ex2.0preserve` and `/usr/lib/ex2.0recover` can write `/usr/preserve` (owned by `root`, mode 4755; directory mode 755). Programs `setenv` and `tset` need write access to `/etc/htmp`.
9. Populate `/etc/ttytype` with terminal types. See `misc/ttytype` and `misc/ttytype.v6` for examples. Terminal codes come from `/etc/termcap`.
10. Edit `/usr/lib/Mail.rc` to define any desired mail aliases.

## Uninstalled Software
The modifications to `src/libNS`, the Berkeley network in `src/net` and the `finger` program (`src/finger.c`) are not installed automatically. Consult their `READ_ME` files for details.

## Version 6 Notes
* Recompiling the editor may overflow the standard compiler symbol table; see `upgrade/c` for a larger-table compiler.
* Binaries on the tape may print Pacific time. Recompile for your time zone if needed.
* `csh` relies on an `access` system call absent from bare V6. See `misc/access.sys` for adding it.
* Adjust `Mail` and `from` in `upgrade/src` if your mail spool differs.
* If you changed the `times` system call to return long values, recompile `csh`.

## Maintenance
* Keep `/etc/termcap` and `/etc/ttytype` up to date when terminals change.
* Periodically clean `/usr/preserve` with:
  ```sh
  find /usr/preserve -mtime +7 -exec rm -f {} \;
  ```
* Clear old entries from `/usr/msgs` every few months.

