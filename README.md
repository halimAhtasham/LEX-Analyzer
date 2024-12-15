# Lexical Analyzer

This repository contains a Lex program to perform lexical analysis. It identifies the following tokens in an input file:

- **Keywords**: Reserved words like `int`, `float`, `if`, etc.
- **Identifiers**: User-defined names.
- **Numbers**: Integers and real numbers.
- **Operators**: Arithmetic and logical operators.
- **Separators**: Symbols like `;`, `{}`, `[]`, etc.
- **Comments**: Both single-line and multi-line comments.
- **Words**: It will print all the words given and count them.

## How to Compile and Run
1. Install Lex (Flex) and GCC and Bison if not already installed.
2. Run the following commands:
   flex file_name.l
   --press enter
   gcc lex.yy.c
   --press enter
   a.exe
   --press enter
   (ctrl + z)

## Sample Input
int x = 10; /* This is a comment*/
float y = 20.5;

## Sample Output
Keyword: int
Identifier: x
Operator: =
Number: 10
Comment: /* This is a comment*/
Keyword: float
Identifier: y
Operator: =
Number: 20.5
