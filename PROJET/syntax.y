%{
#include <stdio.h>
#include<stdlib.h>
#include<string.h>

extern int nb_ligne;
extern int colonne ;

%}
%union{
int num;
float reel;
char* text;
char* id;

}
%token <num> NUM <reel> REAL <text>TEXT <id> IDF
%token DEBUT FIN EXECUTION FIXE SI SINON ALORS TANTQUE FAIRE
%token PLUS MOINS MULT DIV EGAL DIFF INF INFEGAL SUP SUPEGAL ET OU NON
%token DOUBLPTS PTV BRAKL BRAKR AFF
%token affiche lire  
%start S

%%
S: DEBUT declaration EXECUTION bloc FIN{
    print("programme correcte \n");
    YYACCEPT;
}
    declaration: vars
     |
    declaration vars
     ;
         vars: NUM DOUBLPTS IDF PTV{
            printf("Declaration variable entier \n ");
         }
         |REAL DOUBLPTS IDF PTV{
            printf("Declaration variable reel \n");
         }
         | TEXT DOUBLPTS IDF PTV{  
            printf("Declaration variable text \n");
         }
         |FIXE NUM DOUBLPTS IDF AFF NUM PTV{
              printf("Declaration variable constante \n");
         }
        ;
    bloc:BRAKL instructions BRAKR;
         instructions:instruction
         |
         instruction instructions
         ;
            instruction:IDF AFF expression PTV{
                printf("Affectation %s \n ",$1);
            }    
            | affiche BRAKL TEXT BRAKR PTV{
                printf("Affichage \n");
            }
            |lire BRAKL IDF BRAKR PTV{
                printf("Lecture \n"):
            }
            |SI condition ALORS bloc SINON bloc{
                printf(" Condition SI / SINON \n");
            }
            |TANTQUE condition FAIRE bloc{
                printf("Boucle TANTQUE \n");
            }
            ;
               expression:NUM
               |REAL
               |IDF
               |expression PLUS expression
               |expression MOINS expression
               |expression MULT expression
               |expression DIV expression
               ;
               condition:expression EGAL expression
               |expression DIFF expression
               |expression INF expression
               |expression INFEGAL expression
               |expression SUP expression
               |expression SUPEGAL expression
               |condition ET condition
               |condition OU condition
               |NON condition
               ;

%%

main ()
{
yyparse();
}
yywrap()
{}
int yyerror(char *msg)
{printf(" Erreur syntaxique a la ligne %d, a la colonne %d\n",nb_ligne,col);
    return 1;
}