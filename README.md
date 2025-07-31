Here’s a consolidated, conflict-free README.md reflecting our current structure, build tooling, documentation, and dual-license:

# UnixV6_BSD2

A chimera of legacy Unix v6 and 2BSD: which they already were.

## Build

The repository contains numerous historical Makefiles spread across subdirectories. Use the `build.sh` helper to build everything:

```sh
./build.sh               # developer profile (default)
./build.sh -p performance
./build.sh -p release

Each profile adjusts CFLAGS for more debugging information or for optimized binaries—you can inspect build.sh for the exact flags.

Installation

See the step-by-step guide in [docs/INSTALL.md].

Usage

Basic usage examples and tips are in [docs/USAGE.md].

Documentation
	•	Installation instructions: [docs/INSTALL.md]
	•	Usage basics: [docs/USAGE.md]
	•	Modernized manuals: man/
	•	Original troff sources: legacy/

License

This project combines:
	1.	The original Unix v6 code, under the 4-Clause BSD license (1979).
	2.	All subsequent modifications, under the 2-Clause BSD license.

See LICENSE for the full text of both licenses.

