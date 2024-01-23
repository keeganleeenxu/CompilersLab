%option noyywrap
%{
    #include <stdio.h>
%}
D [0-9]
L [A-Z]
%%
{L}{L}?{D}({D}|{L})?[ ]{D}{L}{L} {
    printf("%s\n", yytext);
    }
.   {
    printf("Error!\n");
    }
%%
int main(){
    yylex();
}