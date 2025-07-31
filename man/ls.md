---
date: 2/24/79
section: UCB
title: LS
---

# NAME

ls - list contents of directory

# SYNOPSIS

**ls** \[ options \] name \...

# DESCRIPTION

*Ls*(UCB) is similar to *ls*(1) but has three possible listing formats.
The format chosen depends on whether the output is going to a teletype,
and may also be controlled by option flags. The default format for a
teletype is to list the contents of directories in multi-column format,
with the entries sorted down the columns. (See also the **-x** option
below.) If the standard output is not a teletype, the default format is
to list one entry per line. This is the way *ls*(1) always works.
Finally, there is a stream output format in which files are listed
across the page, separated by \`,\' characters. The **-m** flag enables
this format.

**Note:** Files which are not the contents of a directory being
interpreted are always sorted across the page rather than down the page
in columns. This is because the individual file names may be arbitrarily
long.

New options are:

**-m**

:   force stream output format

**-1**

:   force one entry per line output format, e.g. to a teletype

**-c**

:   force multi-column output, e.g. to a file or a pipe

**-q**

:   force printing of non-graphic characters in file names as the
    character \`?\'; this normally happens only if the output device is
    a teletype

**-x**

:   force columnar printing to be sorted across rather than down the
    page; this is the default if the last character of the name the
    program is invoked with is not an \`l\' or an \`s\'.

# SEE ALSO

ls(1), l(UCB)

# FILES

/etc/passwd to get user ID\'s for **ls -l**.

# BUGS

Newline and tab are considered printing characters in file names.

Output device is assumed to be 80 columns wide. Columns are basically 15
characters wide, 20 characters wide if **-i** or **-s is specified, 25
characters wide if both** **-i** and **-s are specified.** In any case
where **-l** or **-n** is specified, we assume only one entry will fit
per line.

The option setting based on whether the output is a teletype is
undesirable as:

ls -s \| lpr

is much different than

ls -s

On the other hand, not doing this setting would make old shell scripts
which used *ls* almost certain losers, and then one could no longer do,
e.g.:

ls -s \| sort -nr

but would have to do

ls -s -1 \| sort -nr

Column widths choices are poor for terminals which can tab.
