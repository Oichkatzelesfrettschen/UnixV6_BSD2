.nr si 3n
.he 'USING NROFF AND \-ME''%'
.ds U \s-1UNIX\s0
.ds N \s-1NROFF\s0
.ds T \s-1TROFF\s0
.+c
.(l C
.sz 14
.b "WRITING PAPERS WITH NROFF USING \-ME"
.sz
.sp 2
.ul
Eric P. Allman
.sp
Electronics Research Laboratory
University of California, Berkeley
Berkeley, California  94720
.)l
.sp 4
.pp
This document describes
the text processing facilities
available on the \*U\(dg
.(f
\(dg\*U, \*N, and \*T are Trademarks
of Bell Laboratories
.)f
operating system
via \*N\(dg and the
\-me
macro package.
It is assumed
that the reader
already is generally familiar
with the \*U operating system
and a text editor
such as
.b ex .
This is intended to be a casual introduction,
and
as such not all material is covered.
In particular,
many variations and additional features
of the \-me macro package
are not explained.
For a complete discussion of this
and other issues,
see
.ul
The \-me Reference Manual
and
.ul
The \*N/\*T Reference Manual.
.pp
\*N, a computer program
that runs on the \*U operating system,
reads an input file
prepared by the user
and outputs a formatted paper
suitable for publication or framing.
The input consists of
.i text ,
or words to be printed,
and
.i requests ,
which give instructions
to the \*N program
telling how to format the printed copy.
.pp
Section 1
describes the basics
of text processing.
Section 2
describes the basic requests.
Section 3
introduces displays.
Annotations,
such as footnotes,
are handled in
section 4.
The more complex requests
which are not discussed in section 2
are covered in section 5.
Finally,
section 6
discusses things you will need
to know
if you want to typeset documents.
If you are a novice,
you probably won't want to read beyond section 4
until you have tried some of the basic features out.
.pp
When you have your raw text ready,
call the \*N formatter by typing
as a request to the \*U shell:
.(b
nroff \-me \-T\c
.i "type files"
.)b
where
.i type
describes the type of terminal
you are outputting to.
Common values are
.b dtc
for a DTC 300s
(daisy-wheel type)
printer and
.b lpr
for the line printer.
If the
.b \-T
flag is omitted,
a
.q "lowest common denominator"
terminal is assumed;
this is good for previewing output
on most terminals.
A complete description of options
to the \*N command can be found in
.ul
The \*N/\*T Reference Manual.
.pp
The word
.i argument
is used in this manual
to mean a word or number
which appears on the same line
as a request
which modifies the meaning
of that request.
For example,
the request
.(b
\&.sp
.)b
spaces one line,
but
.(b
\&.sp 4
.)b
spaces four lines.
The number
.b 4
is an
.i argument
to the
.b .sp
request
which says to space four lines
instead of one.
Arguments are separated from the request
and from each other
by spaces.
.sh 1 "Basics of Text Processing"
.pp
The primary function
of \*N
is to
.i collect
words from input lines,
.i fill
output lines with those words,
.i justify
the right hand margin by inserting extra spaces
in the line,
and output the result.
For example,
the input:
.(b
Now is the time
for all good men
to come to the aid
of their party.
Four score and seven
years ago,...
.)b
will be read,
packed onto output lines,
and justified
to produce:
.(b F
Now is the time
for all good men
to come to the aid
of their party.
Four score and seven
years ago,...
.)b
Sometimes you may want to start a new output line
even though the line you are on
is not yet full;
for example,
at the end of a paragraph.
To do this
you can cause a
.i break ,
which
starts a new output line.
Some requests
cause a break automatically,
as do blank input lines
and input lines beginning with a space.
.pp
Not all input lines
are text to be formatted.
Some of the input lines
are
.i requests
which describe
how to format the text.
Requests always have a period
or an apostrophe
(\c
.q "\|\(aa\|" )
as the first character
of the input line.
.pp
The text formatter
also does more complex things,
such as automatically numbering pages,
skipping over page folds,
putting footnotes in the correct place,
and so forth.
.pp
I can offer you a few hints
for preparing text
for input to \*N.
First,
keep the input lines short.
Short input lines are easier to edit,
and \*N will pack words onto longer lines
for you anyhow.
In keeping with this,
it is helpful
to begin a new line
after every period,
comma,
or phrase,
since common corrections
are to add or delete sentences
or phrases.
Second,
do not put spaces at the end of lines,
since this can sometimes confuse the \*N
processor.
Third,
do not hyphenate words at the end of lines
(except words that should have hyphens in them,
such as
.q mother-in-law );
\*N is smart enough to hyphenate words
for you as needed,
but is not smart enough
to take hyphens out
and join a word back together.
Also,
words such as
.q mother-in-law
should not be broken
over a line,
since then you will get a space
where not wanted,
such as
.tr @-
.nh
.q "mother@\ in@law" .
.br
.tr @@
.hy 14
.sh 1 "Basic Requests"
.sh 2 "Paragraphs"
.pp
Paragraphs are begun
by using the
.b .pp
request.
For example,
the input:
.(b
\&.pp
Now is the time for all good men
to come to the aid of their party.
Four score and seven years ago,...
.)b
produces a blank line
followed by an indented first line.
The result is:
.(b F
.ti +\n(piu
Now is the time for all good men
to come to the aid of their party.
Four score and seven years ago,...
.)b
.pp
Notice that the sentences
of the paragraphs
.i "must not"
begin with a space,
since blank lines
and lines begining with spaces
cause a break.
For example,
if I had typed:
.(b
\&.pp
Now is the time for all good men
      to come to the aid of their party.
Four score and seven years ago,...
.)b
The output would be:
.(b F
.ti +\n(piu
Now is the time for all good men
      to come to the aid of their party.
Four score and seven years ago,...
.)b
A new line begins after the word
.q men
because the second line began with a space character.
.pp
There are many
fancier
types of paragraphs,
which will be described later.
.sh 2 "Headers and Footers"
.pp
Arbitrary headers and footers
can be put
at the top and bottom
of every page.
Two requests
of the form
.b .he \ \c
.i title
and
.b .fo \ \c
.i title
define the titles to put at the head and the foot
of every page,
respectively.
The titles are called
.i three-part
titles,
that is,
there is a left-justified part,
a centered part,
and a right-justified part.
To separate these three parts
the first character of
.i title
(whatever it may be)
is used as a delimiter.
Any character may be used,
but
backslash
and double quote marks
should be avoided.
The percent sign
is replaced by the current page number
whenever found in the title.
For example,
the input:
.(b
\&.he \(aa\(aa%\(aa\(aa
\&.fo \(aaJane Jones\(aa\(aaMy Book\(aa
.)b
results in the page number
centered at the top
of each page,
.q "Jane Jones"
in the lower left corner,
and
.q "My Book"
in the lower right corner.
.sh 2 "Double Spacing"
.pp
.ls 2
\*N will double space output text automatically if you
use the request
.b ".ls\ 2" ,
as is done in this section.
You can revert to single spaced mode
by typing
.b ".ls\ 1" .
.ls 1
.sh 2 "Page Layout"
.pp
A number of requests allow
you to change the way the printed copy looks,
sometimes called the
.i layout
of the output page.
Most of these requests adjust the placing
of
.q "white space"
(blank lines or spaces).
In these explanations,
characters in italics
should be replaced with values you wish to use;
bold characters
represent characters which should actually be typed.
.pp
The
.b .bp
request
starts a new page.
.pp
The request
.b .sp \ \c
.i N
leaves
.i N
lines of blank space.
.i N
can be omitted
(meaning skip a single line)
or can be of the form
.i N \^\c
.b i
(for
.i N
inches)
or
.i N \^\c
.b c
(for
.i N
centimeters).
For example, the input:
.(b
\&.sp 1.5i
My thoughts on the subject
\&.sp
.)b
leaves one and a half inches of space,
followed by the line
.q "My thoughts on the subject" ,
followed by a single blank line.
.pp
The
.b .in \ \c
.i +N
request
changes the amount of white space
on the left of the page
(the
.i indent ).
The argument
.i N
can be of the form
.b + \c
.i N
(meaning leave
.i N
spaces more than you are already leaving),
.b \- \c
.i N
(meaning leave less than you do now),
or just
.i N
(meaning leave exactly
.i N
spaces).
.i N
can be of the form
.i N \^\c
.b i
or
.i N \^\c
.b c
also.
For example,
the input:
.(b
initial text
\&.in 5
some text
\&.in +1i
more text
\&.in \-2c
final text
.)b
produces
.q "some text"
indented exactly five spaces
from the left margin,
.q "more text"
indented five spaces
plus one inch
from the left margin
(fifteen spaces
on a pica typewriter),
and
.q "final text"
indented five spaces
plus one inch
minus two centimeters
from the margin.
That is,
the output is:
.(b
initial text
.in +5
some text
.in +1i
more text
.in -2c
final text
.)b
.pp
The
.b .ti \ \c
.i +N
(temporary indent)
request is used like
.b .in \ \c
.i +N
when the indent
should apply to one line only,
after which it should revert
to the previous indent.
For example,
the input:
.(b
\&.in 1i
\&.ti 0
Ware, James R.  The Best of Confucius,
Halcyon House, 1950.
An excellent book containing translations of
most of Confucius\(aa most delightful sayings.
A definite must for anyone interested in the early foundations
of Chinese philosophy.
.)b
produces:
.in 1i+\n($iu
.ti \n($iu
Ware, James R.  The Best of Confucius,
Halcyon House, 1950.
An excellent book containing translations of
most of Confucius' most delightful sayings.
A definite must for anyone interested in the early foundations
of Chinese philosophy.
.pp
Text lines can be centered
by using the
.b .ce
request.
The line after the
.b .ce
is centered
(horizontally)
on the page.
To center more than one line,
use
.b .ce \ \c
.i N
(where
.i N
is the number of lines to center),
followed by the
.i N
lines.
If you want to center many lines
but don't want to count them,
type:
.(b
\&.ce 1000
lines to center
\&.ce 0
.)b
The
.b ".ce\ 0"
request tells \*N to center zero more lines,
in other words,
stop centering.
.pp
All of these requests
cause a break;
that is,
they always start
a new line.
If you want to start a new line
without performing any other action,
use
.b .br .
.sh 2 "Underlining"
.pp
Text can be underlined
using the
.b .ul
request.
The
.b .ul
request
causes the next input line
to be underlined when output.
You can underline multiple lines
by stating a count of
.i input
lines to underline,
followed by those lines
(as with the
.b .ce
request).
For example,
the input:
.(b
\&.ul 2
Notice that these two input lines
are underlined.
.)b
will underline those eight words in \*N.
(In \*T they will be set in italics.)
.sh 1 "Displays"
.pp
Displays are sections of text
to be set off
from the body of the paper.
Major quotes,
tables,
and figures
are types of displays,
as are all the examples
used in this document.
All displays
except centered blocks
are output
single spaced.
.sh 2 "Major Quotes"
.pp
Major quotes
are quotes which are several lines long,
and hence are set in from the rest
of the text
without quote marks
around them.
These can be generated
using the commmands
.b .(q
and
.b .)q
to surround the quote.
For example,
the input:
.(b
As Weizenbaum points out:
\&.(q
It is said that to explain is to explain away.
This maxim is nowhere so well fulfilled
as in the areas of computer programming,...
\&.)q
.)b
generates as output:
.lp
As Weizenbaum points out:
.(q
It is said that to explain is to explain away.
This maxim is nowhere so well fulfilled
as in the areas of computer programming,...
.)q
.sh 2 "Lists"
.pp
A
.i list
is an indented,
single spaced,
unfilled display.
Lists should be used
when the material to be printed
should not be filled and justified
like normal text,
such as columns of figures
or the examples used in this paper.
Lists are surrounded
by the requests
.b .(l
and
.b .)l .
For example,
type:
.(b
Alternatives to avoid deadlock are:
\&.(l
Lock in a specified order
Detect deadlock and back out one process
Lock all resources needed before proceeding
\&.)l
.)b
will produce:
.br
Alternatives to avoid deadlock are:
.(l
Lock in a specified order
Detect deadlock and back out one process
Lock all resources needed before proceeding
.)l
.sh 2 "Keeps"
.pp
A
.i keep
is a display of lines
which are kept on a single page
if possible.
An example of where you would use a keep
might be a diagram.
Keeps differ from lists
in that lists may be broken
over a page boundary
whereas keeps will not.
.pp
Blocks are the basic kind of keep.
They begin with the request
.b .(b
and end with the request
.b .)b .
If there is not room on the current page
for everything in the block,
a new page is begun.
This has the unpleasant effect
of leaving blank space
at the bottom of the page.
When this is not appropriate,
you can use the alternative,
called
.i "floating keeps" .
.pp
.i "Floating keeps"
move relative to the text.
Hence,
they are good for things
which will be referred to
by name,
such as
.q "See figure 3" .
A floating keep will appear
at the bottom of the current page
if it will fit;
otherwise,
it will appear at the top
of the next page.
Floating keeps begin with the line
.b .(z
and end with the line
.b .)z .
For an example of a floating keep,
see figure 1.
.(z
.in 1i
.xl -1i
.hl
\&.(z
\&.hl
Text of keep to be floated.
\&.sp
\&.ce
Figure 1.  Example of a Floating Keep.
\&.hl
\&.)z
.sp
.ce
Figure 1.  Example of a Floating Keep.
.hl
.)z
The
.b .hl
request is used
to draw a horizontal line
so that the figure
stands out from the text.
.sh 2 "Fancier Displays"
.pp
Keeps and lists are normally collected in
.i nofill
mode,
so that they are good for tables and such.
If you want a display
in fill mode
(for text),
type
.b ".(l\ F"
(Throughout this section,
comments applied to
.b .(l
also apply to
.b .(b
and
.b .(z ).
This kind of display
will be indented from both margins.
For example,
the input:
.(b
\&.(l F
And now boys and girls,
a newer, bigger, better toy than ever before!
Be the first on your block to have your own computer!
Yes kids, you too can have one of these modern
data processing devices.
You too can produce beautifully formatted papers
without even batting an eye!
\&.)l
.)b
will be output as:
.(b F
And now boys and girls,
a newer, bigger, better toy than ever before!
Be the first on your block to have your own computer!
Yes kids, you too can have one of these modern
data processing devices.
You too can produce beautifully formatted papers
without even batting an eye!
.)b
.pp
Lists and blocks are also normally indented
(floating keeps are normally left justified).
To get a left-justified list,
type
.b ".(l\ L" .
To get a list centered
line-for-line,
type
.b ".(l C" .
For example,
to get a filled,
left justified list, enter:
.(b
\&.(l L F
text of block
\&.)l
.)b
The input:
.(b
\&.(l
first line of unfilled display
more lines
\&.)l
.)b
produces the indented text:
.(b
first line of unfilled display
more lines
.)b
Typing the character
.b L
after the
.b .(l
request produces the left justified result:
.(b L
first line of unfilled display
more lines
.)b
Using
.b C
instead of
.b L
produces the line-at-a-time centered output:
.(b C
first line of unfilled display
more lines
.)b
.pp
Sometimes it may be
that you want to center several lines
as a group,
rather than centering them
one line at a time.
To do this
use centered blocks,
which are surrounded by the requests
.b .(c
and
.b .)c .
All the lines are centered as a unit,
such that the longest line is centered
and the rest are
lined up around that line.
Notice that lines
do not move
relative to each other
using centered blocks,
whereas they do
using the
.b C
argument to keeps.
.pp
Centered blocks are
.i not
keeps,
and may be used
in conjunction
with keeps.
For example,
to center a group of lines
as a unit
and keep them
on one page,
use:
.(b
\&.(b L
\&.(c
first line of unfilled display
more lines
\&.)c
\&.)b
.)b
to produce:
.(b L
.(c
first line of unfilled display
more lines
.)c
.)b
If the block requests
(\c
.b .(b
and
.b .)b )
had been omitted
the result would have been the same,
but with no guarantee
that the lines of the centered block
would have all been on one page.
Note the use of the
.b L
argument to
.b .(b ;
this causes the centered block
to center within the entire line
rather than within the line
minus the indent.
Also,
the center requests
must
be nested
.i inside
the keep requests.
.sh 1 "Annotations"
.pp
There are a number of requests
to save text
for later printing.
.i Footnotes
are printed at the bottom of the current page.
.i "Delayed text"
is intended to be a variant form
of footnote;
the text is printed only 
when explicitly called for,
such as at the end of each chapter.
.i Indexes
are a type of delayed text
having a tag
(usually the page number)
attached to each entry
after a row of dots.
Indexes are also saved
until called for explicitly.
.sh 2 "Footnotes"
.pp
Footnotes begin with the request
.b .(f
and end with the request
.b .)f .
The current footnote number is maintained
automatically,
and can be used by typing \e**,
to produce a footnote number\**.
.(f
\**Like this.
.)f
The number is automatically incremented
after every footnote.
For example,
the input:
.(b
\&.(q
A man who is not upright
and at the same time is presumptuous;
one who is not diligent and at the same time is ignorant;
one who is untruthful and at the same time is incompetent;
such men I do not count among acquaintances.\e**
\&.(f
\e**James R. Ware,
\&.ul
The Best of Confucius,
Halcyon House, 1950.
Page 77.
\&.)f
\&.)q
.)b
generates the result:
.(q
A man who is not upright
and at the same time is presumptuous;
one who is not diligent and at the same time is ignorant;
one who is untruthful and at the same time is incompetent;
such men I do not count among acquaintances.\**
.(f
\**James R. Ware,
.ul
The Best of Confucius,
Halcyon House, 1950.
Page 77.
.)f
.)q
It is important
that the footnote
appears
.i inside
the quote,
so that you can be sure
that the footnote
will appear
on the same page
as the quote.
.sh 2 "Delayed Text"
.pp
Delayed text
is very similar to a footnote
except that it is printed
when called for explicitly.
This allows a list of
references to
appear
(for example)
at the end of each chapter,
as is the convention in some disciplines.
Use
.b \e*#
on delayed text
instead of
.b \e**
as on footnotes.
.pp
If you are using delayed text
as your standard reference mechanism,
you can still use footnotes,
except that you may want to reference them
with special characters*
.(f
*Such as an asterisk.
.)f
rather than numbers.
.sh 2 "Indexes"
.pp
An
.q index
(actually more like a table of contents,
since the entries are not sorted alphabetically)
resembles delayed text,
in that it is saved until called for.
However,
each entry has the page number
(or some other tag)
appended to the last line
of the index entry
after a row of dots.
.pp
Index entries begin with the request
.b .(x
and end with
.b .)x .
The
.b .)x
request may have a argument,
which is the value to print
as the
.q "page number" .
It defaults to the current page number.
If the page number given is an underscore
(\c
.q _ )
no page number
or line of dots
is printed at all.
To get the line of dots
without a page number,
type
.b ".)x """"" ,
which specifies an explicitly null page number.
.pp
The
.b .xp
request prints the index.
.pp
For example,
the input:
.(b
\&.(x
Sealing wax
\&.)x
\&.(x
Cabbages and kings
\&.)x _
\&.(x
Why the sea is boiling hot
\&.)x 2.5a
\&.(x
Whether pigs have wings
\&.)x ""
\&.(x
This is a terribly long index entry, such as might be used
for a list of illustrations, tables, or figures; I expect it to
take at least two lines.
\&.)x
\&.xp
.)b
generates:
.(x
Sealing wax
.)x
.(x
Cabbages and kings
.)x _
.(x
Why the sea is boiling hot
.)x 2.5a
.(x
Whether pigs have wings
.)x ""
.(x
This is a terribly long index entry, such as might be used
for a list of illustrations, tables, or figures; I expect it to
take at least two lines.
.)x
.xp
.pp
The
.b .(x
request may have a single character
argument,
specifying the
.q name
of the index;
the normal index is
.b x .
Thus,
several
.q indicies
may be maintained simultaneously
(such as a list of tables, table of contents, etc.).
.pp
Notice that the index must be printed
at the
.i end
of the paper,
rather than at the beginning
where it will probably appear
(as a table of contents);
the pages may have to be physically rearranged
after printing.
.sh 1 "Fancier Features"
.pp
A large number of fancier requests
exist,
notably requests to provide other sorts of paragraphs,
numbered sections of the form
.b 1.2.3
(such as used in this document),
and multicolumn output.
.sh 2 "More Paragraphs"
.pp
Paragraphs generally start with
a blank line
and with the first line
indented.
It is possible to get
left-justified block-style paragraphs
by using
.b .lp
instead of
.b .pp ,
as demonstrated by the next paragraph.
.lp
Sometimes you want to use paragraphs
that have the
.i body
indented,
and the first line
exdented
(opposite of indented)
with a label.
This can be done with the
.b .ip
request.
A word specified on the same line as
.b .ip
is printed in the margin,
and the body is lined up
at a prespecified position
(normally five spaces).
For example,
the input:
.(b
\&.ip one
This is the first paragraph.
Notice how the first line
of the resulting paragraph lines up
with the other lines in the paragraph.
\&.ip two
And here we are at the second paragraph already.
You may notice that the argument to \c
.b .ip
appears
in the margin.
\&.lp
We can continue text...
.)b
produces as output:
.ip one
This is the first paragraph.
Notice how the first line of the resulting paragraph lines up
with the other lines in the paragraph.
.ip two
And here we are at the second paragraph already.
You may notice that the argument to
.b .ip
appears
in the margin.
.lp
We can continue text without starting a new indented
paragraph
by using the
.b .lp
request.
.pp
If you have spaces in the label of a
.b .ip
request,
you must use an
.q "unpaddable space"
instead of a regular space.
This is typed as a backslash character
(\c
.q \e )
followed by a space.
For example,
to print the label
.q "Part 1" ,
enter:
.(b
\&.ip "Part\e 1"
.)b
.pp
If a label of an indented paragraph
(that is, the argument to
.b .ip )
is longer than the space allocated for the label,
the label will not be separated from the text,
and the rest of the text
will be lined up at the old margin
(and not with the first line of text).
For example,
the input:
.(b
\&.ip longlabel
This paragraph had a long label.
The first character of text on the first line
will not line up with the text on second and subsequent lines,
although they will line up with each other.
.)b
will produce:
.ip longlabel
This paragraph had a long label.
The first character of text on the first line
will not line up with the text on second and subsequent lines,
although they will line up with each other.
.pp
It is possible to change the size of the label
by using a second argument
which is the size of the label.
For example,
the above example could be done correctly
by saying:
.(b
\&.ip longlabel 10
.)b
which will make the paragraph indent
10 spaces for this paragraph only.
If you have many paragraphs to indent
all the same amount,
use the
.i "number register"
.b ii .
For example, to leave one inch of space
for the label,
type:
.(b
\&.nr ii 1i
.)b
somewhere before the first call to
.b .ip .
Refer to the reference manual
for more information.
.pp
If
.b .ip
is used
with no argument at all
no hanging tag will be printed.
For example,
the input:
.(b
\&.ip [a]
This is the first paragraph of the example.
We have seen this sort of example before.
\&.ip
This paragraph is lined up with the previous paragraph,
but it has no tag in the margin.
.)b
produces as output:
.ip [a]
This is the first paragraph of the example.
We have seen this sort of example before.
.ip
This paragraph is lined up with the previous paragraph,
but it has no tag in the margin.
.pp
A special case of
.b .ip
is
.b .np ,
which automatically
numbers paragraphs sequentially from 1.
The numbering is reset at the next
.b .pp ,
.b .lp ,
or
.b .sh
(to be described in the next section)
request.
For example,
the input:
.(b
\&.np
This is the first point.
\&.np
This is the second point.
Points are just regular paragraphs
which are given sequence numbers automatically
by the .np request.
\&.pp
This paragraph will reset numbering by .np.
\&.np
For example,
we have reverted to numbering from one now.
.)b
generates:
.np
This is the first point.
.np
This is the second point.
Points are just regular paragraphs
which are given sequence numbers automatically
by the .np request.
.pp
This paragraph will reset numbering by .np.
.np
For example,
we have reverted to numbering from one now.
.sh 2 "Section Headings"
.pp
Section numbers
(such as the ones used in this document)
can be automatically generated
using the
.b .sh
request.
You must tell
.b .sh
the
.i depth
of the section number
and a section title.
The depth
specifies how many numbers
are to appear
(separated by decimal points)
in the section number.
For example,
the section number
.b 4.2.5
has a depth of three.
.pp
Section numbers
are incremented
in a fairly intuitive fashion.
If you add a number
(increase the depth),
the new number starts out
at one.
If you subtract section numbers
(or keep the same number)
the final number is incremented.
For example,
the input:
.(b
\&.sh 1 "The Preprocessor"
\&.sh 2 "Basic Concepts"
\&.sh 2 "Control Inputs"
\&.sh 3
\&.sh 3
\&.sh 1 "Code Generation"
\&.sh 3
.)b
produces as output the result:
.(b
.b
1.  The Preprocessor
1.1.  Basic Concepts
1.2.  Control Inputs
1.2.1.
1.2.2.
2.  Code Generation
2.1.1.
.)b
.pp
You can specify the section number to begin
by placing the section number after the section title,
using spaces instead of dots.
For example,
the request:
.(b
\&.sh 3 "Another section" 7 3 4
.)b
will begin the section numbered
.b 7.3.4 ;
all subsequent
.b .sh
requests will number relative to this number.
.pp
There are more complex features
which will cause each section to be indented
proportionally to the depth of the section.
For example, if you enter:
.(b
\&.nr si \c
.i N
.)b
each section will be indented by an amount
.i N .
.i N
must have a scaling factor attached,
that is, it must be of the form
.i Nx ,
where
.i x
is a character telling what units
.i N
is in.
Common values for
.i x
are
.b i
for inches,
.b c
for centimeters,
and
.b n
for
.i ens
(the width of a single character).
For example,
to indent each section
one-half inch,
type:
.(b
\&.nr si 0.5i
.)b
After this,
sections will be indented by
one-half inch
per level of depth in the section number.
For example,
this document was produced
using the request
.(b
\&.nr si 3n
.)b
at the beginning of the input file,
giving three spaces of indent
per section depth.
.pp
Section headers without automatically generated numbers
can be done using:
.(b
\&.uh "Title"
.)b
which will do a section heading,
but will put no number on the section.
.sh 2 "Parts of the Basic Paper"
.pp
There are some requests
which assist in setting up
papers.
The
.b .tp
request
initializes for a title page.
There are no headers or footers
on a title page,
and unlike other pages
you can space down
and leave blank space
at the top.
For example,
a typical title page might appear as:
.(b
\&.tp
\&.sp 2i
\&.(l C
THE GROWTH OF TOENAILS
IN UPPER PRIMATES
\&.sp
by
\&.sp
Frank N. Furter
\&.)l
\&.bp
.)b
.pp
The request
.b .th
sets up the environment
of the \*N processor
to do a thesis,
using the rules established at Berkeley.
It defines the correct headers and footers
(a page number in the upper right hand corner only),
sets the margins correctly,
and double spaces.
.pp
The
.b .+c \ \c
.i T
request can be used
to start chapters.
Each chapter is automatically numbered
from one,
and a heading is printed at the top of each chapter
with the chapter number
and the chapter name
.i T .
For example,
to begin a chapter called
.q Conclusions ,
use the request:
.(b
\&.+c "CONCLUSIONS"
.)b
which will produce,
on a new page,
the lines
.(b C
CHAPTER 5
CONCLUSIONS
.)b
with appropriate spacing for a thesis.
Also, the header is moved to the foot of the page
on the first page of a chapter.
Although the
.b .+c
request was not designed to work only with the
.b .th
request,
it is tuned for the format acceptable
for a PhD thesis
at Berkeley.
.pp
If the
title parameter
.i T
is omitted from the
.b .+c
request,
the result is a chapter with no heading.
This can also be used at the beginning
of a paper;
for example,
.b .+c
was used to generate page one
of this document.
.pp
Although
papers traditionally have the abstract,
table of contents,
and so forth at the front of the paper,
it is more convenient to format
and print them last
when using \*N.
This is so that index entries
can be collected and then printed
for the table of contents
(or whatever).
At the end of the paper,
issue the
.b ".++ P"
request,
which begins the preliminary part
of the paper.
After issuing this request,
the
.b .+c
request will begin a preliminary section
of the paper.
Most notably,
this prints the page number
restarted from one
in lower case Roman numbers.
.b .+c
may be used repeatedly
to begin different parts of the
front material
for example,
the abstract,
the table of contents,
acknowledgments,
list of illustrations,
etc.
The request
.b ".++ B"
may also be used
to begin the bibliographic section
at the end of the paper.
For example,
the paper might appear
as outlined in figure 2.
(In this figure,
comments begin with the sequence
.b \e" .)
.(z
.hl
.if t .in 0.5i
.if t .ta 2i
.if n .ta 3i
\&.th	\e" set for thesis mode
\&.fo \(aa\(aaDRAFT\(aa\(aa	\e" define footer for each page
\&.tp	\e" begin title page
\&.(l C	\e" center a large block
THE GROWTH OF TOENAILS
IN UPPER PRIMATES
\&.sp
by
\&.sp
Frank Furter
\&.)l	\e" end centered part
\&.+c INTRODUCTION	\e" begin chapter named "INTRODUCTION"
\&.(x t	\e" make an entry into index `t'
Introduction
\&.)x	\e" end of index entry
text of chapter one
\&.+c "NEXT CHAPTER"	\e" begin another chapter
\&.(x t	\e" enter into index `t' again
Next Chapter
\&.)x
text of chapter two
\&.+c CONCLUSIONS
\&.(x t
Conclusions
\&.)x
text of chapter three
\&.++ B	\e" begin bibliographic information
\&.+c BIBLIOGRAPHY	\e" begin another `chapter'
\&.(x t
Bibliography
\&.)x
text of bibliography
\&.++ P	\e" begin preliminary material
\&.+c "TABLE OF CONTENTS"
\&.xp t	\e" print index `t' collected above
\&.+c PREFACE	\e" begin another preliminary section
text of preface
.sp 2
.in 0
.ce
Figure 2.  Outline of a Sample Paper
.hl
.)z
.sh 2 "Equations and Tables"
.pp
Two special \*U programs exist
to format special types of material.
.b Eqn
and
.b neqn
set equations
for the phototypesetter
and \*N respectively.
.b Tbl
arranges to print
extremely pretty tables
in a variety of formats.
This document will only describe
the embellishments
to the standard features;
consult the reference manuals
for those processors
for a description of their use.
.pp
The
.b eqn
and
.b neqn
programs are described fully
in the document
.ul
Typesetting Mathematics \- Users' Guide
by Brian W. Kernighan
and Lorinda L. Cherry.
Equations are centered,
and are kept on one page.
They are introduced by the
.b .EQ
request and terminated by the
.b .EN
request.
.pp
The
.b .EQ
request may take an
equation number as an
optional argument,
which is printed vertically centered
on the right hand side
of the equation.
If the equation becomes too long
it should be split
between two lines.
To do this, type:
.(b
\&.EQ (eq 34)
text of equation 34
\&.EN C
\&.EQ
continuation of equation 34
\&.EN
.)b
The
.b C
on the
.b .EN
request
specifies that the equation
will be continued.
.pp
The
.b tbl
program produces tables.
It is fully described
(including numerous examples)
in the document
.ul
Tbl \- A Program to Format Tables
by M. E. Lesk.
Tables begin with the
.b .TS
request
and end with the
.b .TE
request.
Tables are normally kept on a single page.
If you have a table which is too big
to fit on a single page,
so that you know it will extend
to several pages,
begin the table with the request
.b ".TS\ H"
and put the request
.b .TH
after the part of the table
which you want
duplicated at the top of every page
that the table is printed on.
For example, a table definition
for a long table might look like:
.ds TA \|\h'.4n'\v'-.2n'\s-4\zT\s0\v'.2n'\h'-.4n'\(ci\|
.if n .ds TA \ \o'-T'\ \"
.(b
\&.TS H
c s s
n n n.
THE TABLE TITLE
\&.TH
text of the table
\&.TE
.)b
.pp
.sh 2 "Two Column Output"
.pp
You can get two column output
automatically
by using the request
.b .2c .
This causes everything after it
to be output in two-column form.
The request
.b .bc
will start a new column;
it differs from
.b .bp
in that
.b .bp
may leave a totally blank column
when it starts a new page.
To revert to single column output,
use
.b .1c .
.sh 2 "Defining Macros"
.pp
A
.i macro
is a collection of requests and text
which may be used
by stating a simple request.
Macros begin with the line
.b ".de" \ \c
.i xx
(where
.i xx
is the name of the macro to be defined)
and end with the line consisting of two dots.
After defining the macro,
stating the line
.b . \c
.i xx
is the same as stating all the other lines.
For example,
to define a macro
that spaces 3 lines
and then centers the next input line,
enter:
.(b
\&.de SS
\&.sp 3
\&.ce
\&..
.)b
and use it by typing:
.(b
\&.SS
\&Title Line
(beginning of text)
.)b
.pp
Macro names may be one or two characters.
In order to avoid conflicts
with names in \-me,
always use upper case letters as names.
The only names to avoid are
.b TS ,
.b TH ,
.b TE ,
.b EQ ,
and
.b EN .
.sh 2 "Annotations Inside Keeps"
.pp
Sometimes you may want to put
a footnote
or index entry inside a keep.
For example,
if you want to maintain a
.q "list of figures"
you will want to do something like:
.(b
\&.(z
\&.(c
text of figure
\&.)c
\&.ce
Figure 5.
\&.(x f
Figure 5
\&.)x
\&.)z
.)b
which you may hope
will give you a figure
with a label
and an entry in the index
.b f
(presumably a list of figures index).
Unfortunately,
the
index entry
is read and interpreted
when the keep is read,
not when it is printed,
so the page number in the index is likely to be wrong.
The solution is to use the magic string
.b \e!
at the beginning of all the lines dealing with the index.
In other words,
you should use:
.(b
\&.(z
\&.(c
Text of figure
\&.)c
\&.ce
Figure 5.
\e!.(x f
\e!Figure 5
\e!.)x
\&.)z
.)b
which will defer the processing of the index
until the figure is output.
This will guarantee
that the page number in the index
is correct.
The same comments apply
to
blocks
(with
.b .(b
and
.b .)b )
as well.
.sh 1 "\*T and the Photosetter"
.pp
With a little care,
you can prepare
documents that
will print nicely
on either a regular terminal
or when phototypeset
using the \*T formatting program.
.sh 2 "Fonts"
.pp
A
.i font
is a style of type.
There are three fonts
that are available simultaneously,
Times Roman,
Times Italic,
and Times Bold,
plus the special math font.
The normal font is Roman.
Text which would be underlined in \*N
with the
.b .ul
request
is set in italics
in \*T.
.pp
There are ways of switching between fonts.
The requests
.b .r ,
.b .i ,
and
.b .b
switch to Roman,
italic,
and bold fonts respectively.
You can set a single word
in some font
by typing (for example):
.(b
\&.i word
.)b
which will set
.i word
in italics
but does not affect the surrounding text.
In \*N,
italic and bold text
is underlined.
.pp
Notice that if you are setting more than one word
in whatever font,
you must surround that word with double quote marks
(`\|"\|')
so that it will appear to the \*N processor as a single word.
The quote marks will not appear in the formatted text.
If you do want a quote mark to appear,
you should quote the entire string
(even if a single word),
and use
.i two
quote marks where you want one to appear.
For example,
if you want to produce the text:
.(b
.i """Master Control\|"""
.)b
in italics, you must type:
.(b
\&.i """Master Control\e|"""
.)b
The
.b \e|
produces a very narrow space
so that the
.q l
does not overlap the quote sign in \*T,
like this:
.(b
.i """Master Control"""
.)b
.pp
There are also several
.q pseudo-fonts
available.
The input:
.(b
\&.(b
\&.u underlined
\&.bi "bold italics"
\&.bx "words in a box"
\&.)b
.)b
generates
.(b
.u underlined
.bi "bold italics"
.bx "words in a box"
.)b
In \*N these all just underline
the text.
Notice that pseudo font requests
set only the single parameter in the pseudo font;
ordinary font requests will begin setting all text
in the special font
if you do not provide a parameter.
No more than one word
should appear
with these three font requests
in the middle of lines.
This is because
of the way \*T justifies text.
For example,
if you were to issue the requests:
.(b
\&.bi "some bold italics"
and
\&.bx "words in a box"
.)b
in the middle of a line
\*T would produce
.bi "some bold italics"
and
.bx "words in a box" ,\c
.if t \p
.if n \& \"
.if t which I think you will agree does not look good.
.if n which would look really lousy in \*T.
.pp
The second parameter
of all font requests
is set in the original font.
For example,
the font request:
.(b
\&.b bold face
.)b
generates
.q bold
in bold font,
but sets
.q face
in the font of the surrounding text,
resulting in:
.(b
.b bold face.
.)b
To set the two words
.b bold
and
.b face
both in
.b "bold face" ,
type:
.(b
\&.b "bold face"
.)b
.pp
You can mix fonts in a word by using the
special sequence
.b \ec
at the end of a line
to indicate
.q "continue text processing" ;
this allows input lines
to be joined together
without a space inbetween them.
For example, the input:
.(b
\&.u under \ec
\&.i italics
.)b
generates
.u under \c
.i italics ,
but if we had typed:
.(b
\&.u under
\&.i italics
.)b
the result would have been
.u under
.i italics
as two words.
.sh 2 "Point Sizes"
.pp
The phototypesetter
supports different sizes of type,
measured in points.
The default point size
is 10 points
for most text,
8 points for footnotes.
To change the pointsize,
type:
.(b
\&.sz \c
.i +N
.)b
where
.i N
is the size wanted in points.
The
.i "vertical spacing"
(distance between the bottom of most letters
(the
.i baseline )
between adjacent lines)
is set to be proportional
to the type size.
.pp
Warning:
changing point sizes
on the phototypesetter
is a slow mechanical operation.
Size changes
should be considered carefully.
.sh 2 "Quotes"
.pp
It is conventional when using
the typesetter to
use pairs of grave and acute accents
to generate double quotes,
rather than the
double quote character
(`\|"\|').
This is because it looks better
to use grave and acute accents;
for example, compare
"quote" to
``quote''.
.pp
In order to make quotes compatible
between the typesetter and terminals,
you may use the sequences
.b \e*(lq
and
.b \e*(rq
to stand for the left and right quote
respectively.
These both appear as
.b """"
on most terminals,
but are typeset as
.b ``
and
.b ''
respectively.
For example,
use:
.(b
\e*(lqSome things aren\(aat true
even if they did happen.\e*(rq
.)b
to generate the result:
.(b
.q "Some things aren't true even if they did happen."
.)b
As a shorthand,
the special font request:
.(b
\&.q "quoted text"
.)b
will generate
.q "quoted text" .
Notice that you must surround
the material to be quoted
with double quote marks
if it is more than one word.
.sh 0
.sp 1i
.b Acknowledgments
.pp
I would like to thank
Bob Epstein,
Bill Joy,
and Larry Rowe
for having the courage
to use the \-me macros
to produce non-trivial papers
during the development stages;
Ricki Blau,
Pamela Humphrey,
and Jim Joyce
for their help with the documentation phase;
and the plethora of people who have contributed ideas
and have given support for the project.
.sp 1i
This document was
.if n \*N'ed
.if t \*T'ed
on \*(td
and applies to version
1.1
of the \-me macros.
