digit	[0-9]
letter [a-zA-Z]
%{
#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include "y.tab.h"
int linenum=0;
%}
%%
\% return percentage;
rules return rules;
(\+|\-|\*|\/) {yylval.string = strdup(yytext); return arithmeticop;}
\->   return pointer;
\|    return or;
[;]	return semicolon;
{digit}+ {yylval.number = atoi(yytext); return integer;}
\( return openpar;
\) return closepar;
int|float {yylval.string = strdup(yytext);
	return type;}
\n linenum++;
[a-z]+ {yylval.string = strdup(yytext);
	return terminal;}
[A-Z]+ {yylval.string = strdup(yytext);
	return nonterminal;}
%%
