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

/*
 * Scanner
 */
int	yylacnt;

#define	YYLASIZ	10

struct	yytok Yla[YYLASIZ];

/*
 * Local helper prototypes
 */
static int	skip_white();
static int	lex_identifier();
static int	lex_number();
static int	lex_fraction();
static int	finish_number();
static int	lex_dot();
static int	lex_string();
static int	process_brace_comment();
static int	process_paren_comment();
static void	unterminated_comment();
static int	illegal_character();
static int	handle_paren();

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
        register char *cp;

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

        for (;;) {
                c = skip_white(c);
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
                                return (lex_identifier(c, cp));
                        case '0': case '1': case '2': case '3': case '4':
                        case '5': case '6': case '7': case '8': case '9':
                                return (lex_number(c, cp));
                        case '"':
                        case '`':
                        case '\'':
                        case '#':
                                return (lex_string(c, cp));
                        case '.':
                                return (lex_dot(c, cp));
                        case '{':
                                c = process_brace_comment();
                                continue;
                        case '(': 
                                c = handle_paren();
                                if (c == '(')
                                        return ('(');
                                continue;
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
                                                continue;
                                        case '\f':
                                                c = getchar();
                                                continue;
                                }
                                if (c <= 0)
                                        return (YEOF);
                                return (illegal_character(c));
                }
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
 * Skip over spaces and tabs.
 */
static int
skip_white(c)
        register int c;
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
 * Scan an identifier or keyword.
 */
static int
lex_identifier(c, cp)
        register int c;
        register char *cp;
{
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
 * Finalize numeric scanning with optional exponent.
 */
static int
finish_number(c, cp, f)
        register int c;
        register char *cp;
        int f;
{
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
        if (f)
                return (YNUMB);
        return (YINT);
}

/*
 * Scan fractional part of a number.
 */
static int
lex_fraction(c, cp, f)
        register int c;
        register char *cp;
        int f;
{
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
        return (finish_number(c, cp, f));
}

/*
 * Scan an unsigned number.
 */
static int
lex_number(c, cp)
        register int c;
        register char *cp;
{
        int f;

        f = 0;
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
                return (lex_fraction(c, cp, f));
        }
        return (finish_number(c, cp, f));
}

/*
 * Handle numbers beginning with a dot.
 */
static int
lex_dot(c, cp)
        register int c;
        register char *cp;
{
        c = getchar();
        if (c == '.')
                return (YDOTDOT);
        if (digit(c)) {
                recovered();
                yerror("Digits required before decimal point");
                *cp++ = '0';
                return (lex_fraction(c, cp, 0));
        }
        yysavc = c;
        return ('.');
}

/*
 * Scan a quoted string or character constant.
 */
static int
lex_string(c, cp)
        register int c;
        register char *cp;
{
        char delim;

        if (c == '"' || c == '`') {
                if (!any(bufp + 1, c))
                        return (illegal_character(c));
                if (!dquote) {
                        recovered();
                        dquote++;
                        yerror("Character/string delimiter is '");
                }
        }
        delim = c;
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
 * Report an unterminated comment and exit.
 */
static void
unterminated_comment()
{
        yerror("Comment does not terminate - QUIT");
        pexit(ERRS);
}

/*
 * Skip a { ... } comment.
 */
static int
process_brace_comment()
{
        register int c;
#ifdef PXP
        getcm('{');
#endif
#ifdef PI
        c = options();
        while (c != '}') {
                if (c <= 0)
                        unterminated_comment();
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
 * Skip a (* ... *) comment.
 */
static int
process_paren_comment()
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
                if (c < 0)
                        unterminated_comment();
                if (c == '(' && (c = getchar()) == '*') {
                        warning();
                        yyset();
                        yerror("(* in a (* ... *) comment");
                }
                if (c == '*') {
                        if ((c = getchar()) != ')')
                                continue;
                        c = getchar();
                        break;
                }
                c = getchar();
        }
        return (c);
#endif
}

/*
 * Handle possible comment after '('.
 */
static int
handle_paren()
{
        register int c;

        c = getchar();
        if (c == '*')
                return (process_paren_comment());
        yysavc = c;
        return ('(');
}

/*
 * Default processing for an illegal character.
 */
static int
illegal_character(c)
        register int c;
{
        do
                yysavc = getchar();
        while (yysavc == c);
        yylval = c;
        return (YILLCH);
}
