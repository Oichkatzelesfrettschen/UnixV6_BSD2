---
date: 4/4/79
section: UCB
title: VI
---

# NAME

vi - screen oriented (visual) display editor based on ex

# SYNOPSIS

**vi** \[ **-t** tag \] \[ **-r** \] \[ **+***lineno* \] name \...

# DESCRIPTION

*Vi* (visual) is a display oriented text editor based on *ex*(UCB). *Ex*
and *vi* run the same code; it is possible to get to the command mode of
*ex* from within *vi* and vice-versa.

The *Vi Quick Reference* card and the *Introduction to Display Editing
with Vi* provide full details on using *vi.*

# FILES

See *ex*(UCB).

# SEE ALSO

ex (UCB), vi (UCB), \`\`Vi Quick Reference\'\' card, \`\`An Introduction
to Display Editing with Vi\'\'.

# BUGS

Scans with **/** and **?** begin on the next line, skipping the
remainder of the current line.

Software tabs using **\^T** work only immediately after the
*autoindent.*

Left and right shifts on intelligent terminals don\'t make use of insert
and delete character operations in the terminal.

The *wrapmargin* option can be fooled since it looks at output columns
when blanks are typed. If a long word passes through the margin and onto
the next line without a break, then the line won\'t be broken.

Insert/delete within a line can be slow if tabs are present on
intelligent terminals, since the terminals need help in doing this
correctly.

Occasionally inverse video scrolls up into the file from a diagnostic on
the last line.

Saving text on deletes in the named buffers is somewhat inefficient.

The *source* command does not work when executed as **:source**; there
is no way to use the **:append**, **:change**, and **:insert** commands,
since it is not possible to give more than one line of input to a **:**
escape. To use these on a **:global** you must **Q** to *ex* command
mode, execute them, and then reenter the screen editor with *vi* or
*open.*
