%{
#include <stdio.h>
#include <ctype.h>
#include <string.h>

// Counters for each token type
int keyword_count = 0, identifier_count = 0, comment_count = 0,
    digit_count = 0, character_count = 0, separator_count = 0,
    operator_count = 0;

// Array to store all words and their counts
struct Word {
    char word[100];
    int count;
} words[1000];
int word_index = 0;

// Function to add or update a word in the words array
void add_word(const char *word) {
    for (int i = 0; i < word_index; i++) {
        if (strcmp(words[i].word, word) == 0) {
            words[i].count++;
            return;
        }
    }
    strcpy(words[word_index].word, word);
    words[word_index].count = 1;
    word_index++;
}
%}

%option noyywrap

%%

"auto"|"break"|"case"|"char"|"const"|"continue"|"default"|"do"|"double"|"else"|"enum"|"extern"|"float"|"for"|"goto"|"if"|"inline"|"int"|"long"|"register"|"restrict"|"return"|"short"|"signed"|"sizeof"|"static"|"struct"|"switch"|"typedef"|"union"|"unsigned"|"void"|"volatile"|"while"|"_Bool"|"_Complex"|"_Imaginary" {
    printf("Keyword: %s\n", yytext);
    keyword_count++;
    add_word(yytext);
}

[a-zA-Z_][a-zA-Z0-9_]* {
    printf("Identifier: %s\n", yytext);
    identifier_count++;
    add_word(yytext);
}

"//".* {
    printf("Single-line Comment: %s\n", yytext);
    comment_count++;
}

"/*"([^*]|\*+[^*/])*\*+"/" {
    printf("Multi-line Comment: %s\n", yytext);
    comment_count++;
}

\+|\-|\*|\/|%|\+\+|\-\-|\&|\||\^|\~|\!|<<|>>|\+=|\-=|\*=|\/=|%=|\&=|\|=|\^= {
    printf("Arithmetic Operator: %s\n", yytext);
    operator_count++;
}

==|!=|<|>|<=|>=|&&|\|\||! {
    printf("Relational Operator: %s\n", yytext);
    operator_count++;
}

=|->|\. {
    printf("Assignment/Access Operator: %s\n", yytext);
    operator_count++;
}

,|;|\(|\)|\{|\}|\[|\]|\? {
    printf("Separator: %s\n", yytext);
    separator_count++;
}

[0-9]+\.[0-9]+([eE][+-]?[0-9]+)? {
    printf("Floating-point Number: %s\n", yytext);
    digit_count++;
}

[1-9][0-9]*([uU]?[lL]?|[lL]?[uU]?) {
    printf("Decimal Integer: %s\n", yytext);
    digit_count++;
}

0[xX][0-9a-fA-F]+([uUlL]|[uU][lL]|[lL][uU])? {
    printf("Hexadecimal Number: %s\n", yytext);
    digit_count++;
}

0[0-7]+([uU]?[lL]?|[lL]?[uU]?) {
    printf("Octal Number: %s\n", yytext);
    digit_count++;
}

0 {
    printf("Zero: %s\n", yytext);
    digit_count++;
}

\'.\' {
    printf("Character Literal: %s\n", yytext);
    character_count++;
}

\"(\\.|[^\"])*\" {
    printf("String Literal: %s\n", yytext);
}

[ \t\n\r]+ { /* Ignore whitespace */ }

. {
    printf("Unknown token: %s\n", yytext);
}

%%

int main() {
    printf("Enter a string: ");
    yylex();

    // Print the counts
    printf("\nToken Counts:\n");
    printf("Keywords: %d\n", keyword_count);
    printf("Identifiers: %d\n", identifier_count);
    printf("Comments: %d\n", comment_count);
    printf("Numbers: %d\n", digit_count);
    printf("Characters: %d\n", character_count);
    printf("Separators: %d\n", separator_count);
    printf("Operators: %d\n", operator_count);

    printf("\nAll Words:\n");
    for (int i = 0; i < word_index; i++) {
        printf("%s: %d\n", words[i].word, words[i].count);
    }

    return 0;
}