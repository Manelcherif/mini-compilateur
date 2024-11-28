flex lexical.l
bison -d syntaxe.y
gcc lex.yy.c syntaxe.tab.c -lfl -ly -o analyseur