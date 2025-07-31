/* Copyright (c) 1979 Regents of the University of California */
#
/*
 * pi - Pascal interpreter code translator
 *
 * Charles Haley, Bill Joy UCB
 * Version 1.2 January 1979
 *
 *
 * pxp - Pascal execution profiler
 *
 * Bill Joy UCB
 * Version 1.2 January 1979
 */

#include "0.h"
#include "yy.h"

/* Forward declarations for lexical helpers */
STATIC int      skipwhite(register int c);
STATIC int      lex_identifier(register int c);
STATIC int      lex_number(register int c);
STATIC int      lex_dot_number(register int c);
STATIC int      lex_string(int delim);
STATIC int      lex_brace_comment(void);
STATIC int      lex_paren_comment(void);
STATIC int      lex_illegal(int ch);

/*
 * Scanner
 */
int	yylacnt;

#define	YYLASIZ	10

struct	yytok Yla[YYLASIZ];

unyylex(y)
	struct yylex *y;
{

	if (yylacnt == YYLASIZ)
		panic("unyylex");
	copy(&Yla[yylacnt], y, sizeof Yla[0]);
	yylacnt++;

}

yylex()
{
	register c;
	register **ip;
	register char *cp;
	int f;
	char delim;

	if (yylacnt != 0) {
		yylacnt--;
		copy(&Y, &Yla[yylacnt], sizeof Y);
		return (yychar);
	}
	if (c = yysavc)
		yysavc = 0;
	else
		c = getchar();
#ifdef PXP
	yytokcnt++;
#endif

next:
       c = skipwhite(c);
       yyecol = yycol;
       yyeline = yyline;
       yyefile = filename;
	yyeseqid = yyseqid;
	yyseekp = yylinpt;
	cp = token;
	yylval = yyline;
	switch (c) {
               case 'a': case 'b': case 'c': case 'd': case 'e': case 'f': case 'g':
               case 'h': case 'i': case 'j': case 'k': case 'l': case 'm': case 'n':
               case 'o': case 'p': case 'q': case 'r': case 's': case 't': case 'u':
               case 'v': case 'w': case 'x': case 'y': case 'z':
               case 'A': case 'B': case 'C': case 'D': case 'E': case 'F': case 'G':
               case 'H': case 'I': case 'J': case 'K': case 'L': case 'M': case 'N':
               case 'O': case 'P': case 'Q': case 'R': case 'S': case 'T': case 'U':
               case 'V': case 'W': case 'X': case 'Y': case 'Z':
                       return (lex_identifier(c));
               case '0': case '1': case '2': case '3': case '4':
               case '5': case '6': case '7': case '8': case '9':
                       return (lex_number(c));
               case '"':
               case '`':
               case '\'':
               case '#':
                       return (lex_string(c));
               case '.':
                       c = getchar();
                       if (c == '.')
                               return (YDOTDOT);
                       if (digit(c)) {
                               recovered();
                               yerror("Digits required before decimal point");
                               return (lex_dot_number(c));
                       }
                       yysavc = c;
                       return ('.');
               case '{':
                       c = lex_brace_comment();
                       goto next;
               case '(': 
                       if ((c = getchar()) == '*') {
                               c = lex_paren_comment();
                               goto next;
                       }
                       yysavc = c;
                       c = '(';
		case ';':
		case ',':
		case ':':
		case '=':
		case '*':
		case '+':
		case '/':
		case '-':
		case '|':
		case '&':
		case ')':
		case '[':
		case ']':
		case '<':
		case '>':
		case '~':
		case '^':
			return (c);
		default:
			switch (c) {
				case YDOTDOT:
					return (c);
				case '\n':
					c = getchar();
#ifdef PXP
					yytokcnt++;
#endif
					goto next;
				case '\f':
					c = getchar();
					goto next;
			}
			if (c <= 0)
				return (YEOF);
illch:
			do
				yysavc = getchar();
			while (yysavc == c);
			yylval = c;
			return (YILLCH);
	}
}

yyset()
{

	yyecol = yycol;
	yyeline = yyline;
	yyefile = filename;
	yyseekp = yylinpt;
}

/*
 * Setuflg trims the current
 * input line to at most 72 chars
 * for the u option.
 */
setuflg()
{

        if (charbuf[71] != '\n') {
                charbuf[72] = '\n';
                charbuf[73] = 0;
        }
}

/*
 * Skip over blanks and tabs.
 */
STATIC int
skipwhite(register int c)
{
#ifdef PXP
       yywhcnt = 0;
#endif
       while (c == ' ' || c == '\t') {
#ifdef PXP
               if (c == '\t')
                       yywhcnt++;
               yywhcnt++;
#endif
               c = getchar();
       }
       return (c);
}

/*
 * Scan an identifier or keyword beginning with character c.
 */
STATIC int
lex_identifier(register int c)
{
       register char *cp = token;
       register **ip;

       do {
               *cp++ = c;
               c = getchar();
       } while (alph(c) || digit(c));
       *cp = 0;
       if (opt('s'))
               for (cp = token; *cp; cp++)
                       if (*cp >= 'A' && *cp <= 'Z')
                               *cp =| ' ';
       yysavc = c;
       ip = hash(0, 1);
       if (*ip < yykey || *ip >= lastkey) {
               yylval = *ip;
               return (YID);
       }
       yylval = yyline;
       return ((*ip)[1]);
}

/*
 * Scan a number beginning with digit c.
 */
STATIC int
lex_number(register int c)
{
       register char *cp = token;
       int f = 0;

       do {
               *cp++ = c;
               c = getchar();
       } while (digit(c));
       if (c == 'b' || c == 'B') {
               if (opt('s')) {
                       standard();
                       yerror("Octal constants are non-standard");
               }
               *cp = 0;
               yylval = copystr(token);
               return (YBINT);
       }
       if (c == '.') {
               c = getchar();
               if (c == '.') {
                       *cp = 0;
                       yysavc = YDOTDOT;
                       yylval = copystr(token);
                       return (YINT);
               }
               f++;
               *cp++ = '.';
               if (!digit(c)) {
                       yyset();
                       recovered();
                       yerror("Digits required after decimal point");
                       *cp++ = '0';
               } else
                       while (digit(c)) {
                               *cp++ = c;
                               c = getchar();
                       }
       }
       if (c == 'e' || c == 'E') {
               f++;
               *cp++ = c;
               if ((c = yysavc) == 0)
                       c = getchar();
               if (c == '+' || c == '-') {
                       *cp++ = c;
                       c = getchar();
               }
               if (!digit(c)) {
                       yyset();
                       yerror("Digits required in exponent");
                       *cp++ = '0';
               } else
                       while (digit(c)) {
                               *cp++ = c;
                               c = getchar();
                       }
       }
       *cp = 0;
       yysavc = c;
       yylval = copystr(token);
       return (f ? YNUMB : YINT);
}

/*
 * Scan a real number which began with a leading '.'.
 */
STATIC int
lex_dot_number(register int c)
{
       register char *cp = token;

       *cp++ = '0';
       *cp++ = '.';
       if (!digit(c)) {
               yyset();
               recovered();
               yerror("Digits required after decimal point");
               *cp++ = '0';
       } else
               while (digit(c)) {
                       *cp++ = c;
                       c = getchar();
               }
       if (c == 'e' || c == 'E') {
               *cp++ = c;
               if ((c = yysavc) == 0)
                       c = getchar();
               if (c == '+' || c == '-') {
                       *cp++ = c;
                       c = getchar();
               }
               if (!digit(c)) {
                       yyset();
                       yerror("Digits required in exponent");
                       *cp++ = '0';
               } else
                       while (digit(c)) {
                               *cp++ = c;
                               c = getchar();
                       }
       }
       *cp = 0;
       yysavc = c;
       yylval = copystr(token);
       return (YNUMB);
}

/*
 * Scan a quoted string or character constant.
 */
STATIC int
lex_string(int delim)
{
       register char *cp = token;
       register int c = delim;

       if (!any(bufp + 1, delim))
               return (lex_illegal(delim));
       if (!dquote) {
               recovered();
               dquote++;
               yerror("Character/string delimiter is '");
       }
       do {
               do {
                       c = getchar();
                       if (c == '\n') {
                               yerror("Unmatched %c for string", delim);
                               if (cp == token)
                                       *cp++ = ' ', cp++;
                               break;
                       }
                       *cp++ = c;
               } while (c != delim);
               c = getchar();
       } while (c == delim);
       *--cp = 0;
       if (cp == token) {
               yerror("Null string not allowed");
               *cp++ = ' ';
               *cp++ = 0;
       }
       yysavc = c;
       yylval = copystr(token);
       return (YSTRING);
}

/*
 * Process a { ... } comment and return the following character.
 */
STATIC int
lex_brace_comment()
{
       register int c;
#ifdef PXP
       getcm('{');
#endif
#ifdef PI
       c = options();
       while (c != '}') {
               if (c <= 0) {
                       yerror("Comment does not terminate - QUIT");
                       pexit(ERRS);
               }
               if (c == '{') {
                       warning();
                       yyset();
                       yerror("{ in a { ... } comment");
               }
               c = getchar();
       }
#endif
       c = getchar();
       return (c);
}

/*
 * Process a (* ... *) style comment and return the following character.
 */
STATIC int
lex_paren_comment()
{
       register int c;
#ifdef PXP
       getcm('*');
       c = getchar();
       return (c);
#endif
#ifdef PI
       c = options();
       for (;;) {
               if (c < 0) {
                       yerror("Comment does not terminate - QUIT");
                       pexit(ERRS);
               }
               if (c == '(' && (c = getchar()) == '*') {
                       warning();
                       yyset();
                       yerror("(* in a (* ... *) comment");
               }
               if (c == '*') {
                       if ((c = getchar()) != ')')
                               continue;
                       c = getchar();
                       return (c);
               }
               c = getchar();
       }
#endif
}

/*
 * Handle an illegal character token.
 */
STATIC int
lex_illegal(int ch)
{
       do
               yysavc = getchar();
       while (yysavc == ch);
       yylval = ch;
       return (YILLCH);
}
