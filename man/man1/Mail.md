---
date: 2/24/79
section: UCB
title: MAIL
---

# NAME

Mail - interactive mail processing system

# SYNOPSIS

**Mail** \[ **-f** \[ name \] \] \[ people \... \]

# DESCRIPTION

*Mail* is a intelligent mail processing system, which has a command
syntax reminiscent of *ed* with lines replaced by messages. In normal
usage, it is given no arguments and checks your mail out of the post
office, then printing out a one line header of each message there. The
current message is initially the first message (numbered 1) and can be
printed using the **print** command (which can be abbreviated **p**).
You can move among the messages much as you move between lines in *ed,*
with the commands \`+\' and \`-\' moving backwards and forwards, and
simple numbers typing the addressed message.

After examining a message you can **delete** (**d**) the message or
**reply** (**r**) to it. Deletion causes the *Mail* program to forget
about the message. This is not irreversible, the message can be
**undeleted** (**u**) by giving its number, or the *Mail* session can be
aborted by giving the **exit** (**x**) command. Deleted messages will,
however, usually disappear never to be seen again.

When you give the **reply** command, *Mail* sets up a response to the
original message, sending it back to the person who it was from. Text
you then type in, up to an end-of-file, defines the contents of the
message. While you are composing a message, *Mail* treats lines
beginning with the character \`\~\' specially. The following \`\~\'
escapes are the most useful:

**\~m**

:   Places a copy of the current message in the response message text,
    right shifting it by a tab stop.

**\~s**

:   Sets a subject for the message. The subject follows the \`\~s\' on
    the same line, and appears in the header for the message when
    received with *Mail.* If there was a subject in the mail being
    responded to, then this is the subject of the response unless you
    give a new one.

**\~c**

:   Adds carbon copies, users who will receive the message also. By
    default, only the originator of the message receives a **reply.**

**\~e**

:   Invokes an editor on the response composed so far. When editing
    terminates, message composition continues.

**\~p**

:   Prints the message composed so far.

You can end a *Mail* session with the **quit** (**q**) command. Messages
which have been examined go to your *mbox* file unless they have been
deleted in which case they are discarded. Unexamined messages go back to
the post office.

By giving \`people\' arguments to *Mail* on the command line, or by
using the internal **mail** (**m**) command you can originate mail. The
escapes available during *reply* commands are available here also.

The **-f** option causes *Mail* to read in the contents of your *mbox*
(or the specified file) for processing; when you **quit** *Mail* writes
undeleted messages back to this file.

*Mail* has a number of other facilities as well as options which can be
set in the file *.mailrc* in your home directory. See the \`Mail
Reference Manual\' for details.

# FILES

/usr/spool/mail/\* post office\
\~/mbox your old mail\
\~/.mailrc file giving initial mail commands\
/tmp/R# temporary for editor escape\
/usr/lib/Mail.groups named groupings for bulk mailing\
/usr/lib/Mail.help\* help files\
/usr/lib/Mail.rc system-wide initialization file\
/bin/mail to do actual mailing

# SEE ALSO

mail(1), \`The Mail Reference Manual\'

# AUTHOR

Kurt Shoens

# BUGS
