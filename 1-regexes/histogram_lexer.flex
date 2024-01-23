%option noyywrap

%{
/* Now in a section of C that will be embedded
   into the auto-generated code. Flex will not
   try to interpret code surrounded by %{ ... %} */

/* Bring in our declarations for token types and
   the yylval variable. */
#include "histogram.hpp"


// This is to work around an irritating bug in Flex
// https://stackoverflow.com/questions/46213840/get-rid-of-warning-implicit-declaration-of-function-fileno-in-flex
extern "C" int fileno(FILE *stream);

/* End the embedded code section. */
%}


%%

[0-9]+          { 
                  fprintf(stderr, "Number : %s\n", yytext); 
                  
                  /* TODO: get value out of yytext and into yylval.numberValue */
                  // FROM TA: In the case of a number, yytext is a pointer to an array of chars so conversion to double before assignment must take place
                  //          The atof() function takes the string pointer and returns a double in its place comprised of the number in the string pointer
                  yylval.numberValue = atof(yytext);

                  return Number; 
                }

[a-z]+          { 
                  fprintf(stderr, "Word : %s\n", yytext); 
                  
                  /* TODO: get value out of yytext and into yylval.wordValue */
                  // FROM TA: In the case of a word, yytext is still a pointer to an array of chars but now the chars need to be concatenated into a string.
                  //          The std::string() obj class can take an array as input
                  yylval.wordValue = new std::string(yytext);

                 return Word; 
                }

\n              { fprintf(stderr, "Newline\n"); }

%%

/* Error handler. This will get called if none of the rules match. */
void yyerror (char const *s)
{
  fprintf (stderr, "Flex Error: %s\n", s); /* s is the text that wasn't matched */
  exit(1);
}
