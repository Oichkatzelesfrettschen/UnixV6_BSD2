# NAME

finger - user information lookup program

# SYNOPSIS

**finger** \[ **-bfhilmpqsw** \] login \...

# DESCRIPTION

*Finger* lists the login name, full name, terminal name and write status
(as a \'\*\' before the terminal name if write permission is denied),
idle time, login time, and office location and phone number (if they are
known) for each current UNIX user, examining the /etc/utmp, /etc/passwd,
and /usr/adm/lastlog files to obtain its information.

*Finger* takes control arguments, preceded by a dash, followed by an
optional list of login names. With no list of login names, the list of
users currently logged on is used.

*Finger* has three output modes - quick, short and long. In quick mode,
data is only retrieved from /etc/utmp, providing only login name,
terminal name, and login time in a format similar to *who*(1). In short
mode, *finger* gives a one line per user output containing login name,
full name, terminal name and write status (a \'\*\' before the terminal
name indicates write permission is denied), idle time (the time since
the user last typed anything meaningful), login time, and office
location and phone number (if the user is logged in on a dialup, her
home phone number is printed instead of office and office phone). Any
items not found are omitted. The format for the idle time is minutes, if
it is a single integer, hours and minutes if a \':\' is present, or days
and hours if a \'d\' is present. Long mode causes *finger* to print all
the information that short mode gives in a multi-line, easy to read
format. In addition, it also prints the users home directory and login
shell, and, if a file .plan exists in her home directory, it is printed
in its entirety; if a file .project exits in her home directory its
first line is printed.

The control arguments to *finger* have the following effect:

**-b**

:   When doing long format output, suppress the printing of the home
    directory and shell fields.

**-f**

:   Suppress the printing of the header line when doing quick or short
    style outputs.

**-h**

:   Suppress the printing of .project files when doing long style
    outputs.

**-i**

:   Do a quick style output, but also lookup idle times and terminal
    status.

**-l**

:   Force long style format; this option only has effect if no login
    name list is given (since it is the default if a list is given).

**-m**

:   Instead of just comparing the listed names with all login names, the
    \"-m\" option also forces comparison with the user\'s real names
    stored in the gecos field of /etc/passwd. This allows you, for
    example, to find all users that have a first name of \`\`bill\'\' or
    a last name of \`\`cooper\'\', for example.

**-p**

:   Suppress the printing of .plan files when doing long style outputs.

**-q**

:   Force quick style outputs.

**-s**

:   Force short style outputs; this option only has effect if a name
    list is given (since it is the default if none is given).

**-w**

:   Decrease the width of short style outputs (by removing the name
    field) for narrow displays.

*Finger* is smart about a user being logged in more than once, and will
do separate lookups for each terminal on which a user is logged in.

The only problem with *finger* is one of unportability; the source of
the information *finger* uses is the gecos field of /etc/passwd, which
UCB VAX/UNIX uses for comment information on the user.

# FILES

/etc/utmp who file\
/etc/passwd for users names, offices, phones, directories and shells\
/usr/adm/lastlog last login times\
\~/.plan plans\
\~/.project projects

# SEE ALSO

who(1)

# BUGS

/usr/adm/lastlog is a local addition at UCB. If no equivalent is present
then finger would have to look backwards through /usr/adm/wtmp, which
would be very slow.

# AUTHOR

Earl T. Cohen
