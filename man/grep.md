---
date: 2/24/79
section: UCB
title: GREP
---

# NAME

grep - search a file for a pattern

# SYNOPSIS

**grep** \[ **-v** \] \[ **-b** \] \[ **-c** \] \[ **-n** \] \[ **-l**
\] \[ **-i** \] \[ **-w** \] expression \[ file \] \...

# DESCRIPTION

*Grep* searches the input files (standard input default) for lines
matching the regular expression. Normally, each line found is copied to
the standard output. If the **-v** flag is used, all lines but those
matching are printed. If the **-c** flag is used, only a count of
matching lines is printed. If the **-l** flag is used, only names of
files which contain matching lines are printed. If the **-i** flag is
used, then case of letters is ignored in comparisons. If the **-w** flag
is used, then the expression is searched for as a word (as if surrounded
by \`\\\<\' and \`\\\>\', see *ex*(UCB)) If the **-n** flag is used,
each line is preceded its relative line number in the file. If the
**-b** flag is used, each line is preceded by the block number on which
it was found. This is sometimes useful in locating disk block numbers by
context.

In all cases the file name is shown if there is more than one input
file.

For a complete description of the regular expressions, see *ex*(UCB).
Care should be taken when using the characters \$ \* \[ \^ \| ( ) and \\
in the regular expression as they are also meaningful to the Shell. It
is generally necessary to enclose the entire *expression* argument in
quotes.

# SEE ALSO

ex(UCB)

# BUGS

Lines are limited to 256 characters; longer lines are truncated.
