# `ex` Usage Basics

This document distills key information from `doc/ex/ex.rm`, the original reference manual for the `ex` editor. It covers starting the editor, common modes, recovery, and command conventions.

## Starting `ex`
Invoke the editor with:

```sh
ex [ - ] [ -v ] [ -t <tag> ] [ -r ] [ +<lineno> ] file ...
```

* `-` suppresses interactive feedback and is useful in scripts.
* `-v` starts in `vi` visual mode.
* `-t <tag>` edits the file containing `<tag>` and positions the cursor at that definition.
* `-r` recovers the last saved version of a file after a crash.
* `+<lineno>` begins editing at the specified line number.

`ex` determines your terminal type from the `TERM` environment variable. If `$HOME/.exrc` exists, commands in that file are executed at startup.

## Editing Modes
`ex` has five modes:

1. **Command mode** – The default when a `:` prompt is visible. Each line you type is executed as an editor command.
2. **Text input mode** – Entered by commands like `append`, `insert`, and `change`. End input with a line containing only a period (`.`).
3. **Open mode** – Displays one line at a time on any terminal, allowing local edits.
4. **Visual mode** – A full‑screen mode (invoked by `vi`) for CRT terminals with cursor addressing.
5. **Text insertion mode** – Used inside open or visual mode when adding text.

## File Handling
`ex` edits the contents of a single *current file* stored in a temporary buffer. Writing the buffer with the `write` command replaces the file on disk. The previous file name becomes the *alternate file* and may be referenced via `#`. The percent sign (`%`) in file names expands to the current file.

## Recovering from Crashes
If the editor or system crashes, `ex` attempts to preserve your buffer. Upon logging back in, run:

```sh
ex -r filename
```

This retrieves the saved copy. Run `ex -r` with no file name to list recoverable files.

## Command Structure
Most commands are English words and may be abbreviated to unique prefixes. Many accept line addresses before the command and additional parameters after it. Commands executed in files can also be read from a script using the `:` prompt.

For a condensed listing of commands, see `doc/ex/ex.summary` in the repository.

