---
date: 3/1/79
section: UCB
title: TSET
---

# NAME

tset - set terminal modes

# SYNOPSIS

**tset** \[ **-** \] \[ **-r** \] \[ **-e** \] \[ **-E** \] \[ **-k** \]
\[ **-d** *type* \] \[ **-p** *type* \] \[ **-b** *type* \] \[ **-h** \]
\[ *type* \]

# DESCRIPTION

*Tset* causes terminal dependent processing such as setting erase and
kill characters, setting or resetting delays, and the like. It is driven
by the */etc/ttytype* and */etc/termcap* files.

The type of terminal is specified by the *type* argument. The type may
be any type given in */etc/termcap.* If *type* is not specified, the
terminal type is read from the environment unless some of the **-h,**
**-d,** **-b,** or **-p** flags are set. In this case the type is read
from */etc/ttytype* (the terminal code to terminal type database). The
terminal id is specified by a *ttyn*(3) call on the diagnostic output.

If the type turns out to be a dialup and the **-d** flag is specified,
the terminal type is taken to be the named type. Similarly, if the type
turns out to be a plugboard and the **-p** flag is specified, the
terminal type assumed is taken to be *type .* The same applies to the
**-b** flag on a bussiplexer port.

On terminals that can backspace but not overstrike (such as a CRT) the
erase character is changed to a Control-H (backspace). The **-e** flag
sets the erase character to be the named character *c* on all terminals,
so to override this option one can say **-e**#. The default for *c* is
Control-H. The **-k** option works similarly, with *c* defaulting to
Control-X. No kill processing is done if **-k** is not specified.

The **-** option prints the terminal type on the standard output.

The **-r** option prints the terminal type on the diagnostic output.

*Tset* is most useful when included in the **.login** file executed
automatically at login, with **-d** used to specify the terminal type
you most frequently dial in on.

# EXAMPLE

tset -dti733 -e -k!\
\
tset gt42

# FILES

/etc/ttytype Terminal id to type map database\
/etc/termcap Terminal capability database

# SEE ALSO

setenv (in csh (UCB))

# AUTHOR

Eric P. Allman
