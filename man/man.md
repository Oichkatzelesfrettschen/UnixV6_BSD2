# NAME

man - run of section of UNIX manual

# SYNOPSIS

**man** \[ **-** \] \[ **-t** \] \[ section \] title \...

# DESCRIPTION

*Man* is a program which prints sections of the manual. *Section* is an
option arabic section number, i.e. 3, which may be followed by a single
letter classifier, i.e. 1m indicating a maintenance type program in
section 1. It may also be \`\`ucb\'\', \`\`sccs\'\', or \`\`public\'\'.
If a section specifier is given *man* looks in the that section of the
manual for the given *titles.* If *section* is omitted, *man* searches
all sections of the manual, giving preference to commands over
subroutines in system libraries, and printing the first section it
finds, if any. The command *apropos*(UCB) can help find a command whose
name has been forgotten, looking it up by kewords in its \`\`one
line\'\' description.

If the standard output is a teletype, or if the flag **-** is given,
then *man* pipes its output through *ssp*(UCB) to crush out useless
blank lines, and through *cr3*(UCB) to stop after each page on the
screen. Hit a carriage return to continue, a control-D to scroll 12 more
lines when the output stops.

The **-t** flag causes *man* to arrange for the specified section to be
*troff\'ed* to the Versatec.

# FILES

/usr/man/man?/\*

# SEE ALSO

apropos(UCB), cr3(UCB), ssp(UCB), whereis(UCB)

# AUTHOR

Bill Joy

# BUGS

The manual is supposed to be reproducible either on the phototypesetter
or on a typewriter. However, on a typewriter some information is
necessarily lost.

If multiple sections of the manual are to be *troff\'ed* then it is
better to run them off with *vtroff*(UCB)*using*a*sequence*like

> cd /usr/man/mann; vtroff -man mail.n msgs.n

since the pages will then be run in one Versatec job using less paper.
