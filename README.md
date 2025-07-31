# UnixV6_BSD2
A chimera of legacy Unix v6 and 2BSD: which they already were.

## Build

The repository contains numerous historical makefiles spread across
subdirectories.  The `build.sh` script walks through each directory and
invokes `make` automatically.

```
./build.sh               # developer profile (default)
./build.sh -p performance
./build.sh -p release
```

Profiles adjust `CFLAGS` for debugging or optimized binaries.  See the
script for details.
