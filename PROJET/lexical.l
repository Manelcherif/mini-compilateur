%{
    int nb_ligne=1;
    int colonne = 1;
     #include "syn.tab.h"
     #include "TS.h"
     #include <string.h> 
     #include <stdlib.h>
	extern YYSTYPE yylval;
%}
lettre [a-zA-Z]
chiffre [0-9]
IDF {lettre}({lettre}|{chiffre})*
NUM {chiffre}*
REAL {chiffre}*"."{chiffre}* 
TEXT \"[^\"]*\"
/*les commentaire*/
commentaire1   "--"[^#]*"##" 
commentaire2   "\{-"([^-]|"-"|[^-}])*"-}" 

%%

{IDF} { yylval.str=strdup(yytext);
			  rechercher(yytext,"IDF","","",1);  
              Col= Col + strlen(yytext);
			  if (yyleng>10) printf ("Erreur Lexical: IDF trop long a la ligne %d a la colonne %d \n",nb_ligne, Col);
              else{printf (" L'entite reconnue est %s \n", yytext); 
			   return IDF;}
      }
{NUM} { yylval.entier = atoi(yytext); // Stocker la valeur numérique
    rechercher(yytext, "Const", "NUM", yytext, 1);
    Col += yyleng;
    printf(" L'entité reconnue : %s\n", yytext);
   return NUM;}
{REAL}{ yylval.real = atof(yytext); // Stocker la valeur réelle
    rechercher(yytext, "Const", "REAL", yytext, 1);
    Col += yyleng;
    printf(" L'entité reconnue : %s\n", yytext);
    return REAL;}
{TEXT}{printf("text"); return TEXT;}

/*mots cles*/
"DEBUT"  { rechercher(yytext, "MOTCLE", "", "", 2);return DEBUT;}
"FIN" {rechercher(yytext, "MOTCLE", "", "", 2);return FIN;}
"EXECUTION"{rechercher(yytext, "MOTCLE", "", "", 2);return EXECUTION;}
"FIXE" {rechercher(yytext, "MOTCLE", "", "", 2);return FIXE;}
"SI" {rechercher(yytext, "MOTCLE", "", "", 2);return SI;}
"SINON" {rechercher(yytext, "MOTCLE", "", "", 2);return SINON;}
"ALORS" {rechercher(yytext, "MOTCLE", "", "", 2);return ALORS;}
"TANTQUE" {rechercher(yytext, "MOTCLE", "", "", 2);return TANTQUE;}
"FAIRE" {rechercher(yytext, "MOTCLE", "", "", 2);return FAIRE;}
"NUM" {rechercher(yytext, "MOTCLE", "", "", 2);return entier;}
"REAL" {rechercher(yytext, "MOTCLE", "", "", 2);return reel ;}
"TEXT" {rechercher(yytext, "MOTCLE", "", "", 2);return text;}
"affiche" {rechercher(yytext, "MOTCLE", "", "", 2);return AFFICHE;}
"lire" {rechercher(yytext, "MOTCLE", "", "", 2);return LIRE;}

/* operateurs*/
"<-" {rechercher(yytext, "Operateur", 0, "", 3); Col += yyleng;return AFF;}
"+"{rechercher(yytext, "Operateur", 0, "", 3); Col += yyleng;return PLUS;}
"-"{rechercher(yytext, "Operateur", 0, "", 3); Col += yyleng;return MOINS;}
"*" {rechercher(yytext, "Operateur", 0, "", 3); Col += yyleng;return MULT;}
"/" {rechercher(yytext, "Operateur", 0, "", 3); Col += yyleng;return DIV;}
"="{rechercher(yytext, "Operateur", 0, "", 3); Col += yyleng;return EGAL;}
"!="{rechercher(yytext, "Operateur", 0, "", 3); Col += yyleng;return DIFF;}
"<"{rechercher(yytext, "Operateur", 0, "", 3); Col += yyleng;return INF;}
"<="{rechercher(yytext, "Operateur", 0, "", 3); Col += yyleng;return INFEGAL;}
">"{rechercher(yytext, "Operateur", 0, "", 3); Col += yyleng;return SUP;}
">="{rechercher(yytext, "Operateur", 0, "", 3); Col += yyleng;return SUPEGAL;}
"ET"{rechercher(yytext, "Operateur", 0, "", 3); Col += yyleng;return ET;}
"OU" {rechercher(yytext, "Operateur", 0, "", 3); Col += yyleng;return OU;}
"NON" {rechercher(yytext, "Operateur", 0, "", 3); Col += yyleng;return NON;}
"{" {rechercher(yytext, "Separateur", 0, "", 3); Col += yyleng;return BRAKL;}
"}"{rechercher(yytext, "Separateur", 0, "", 3); Col += yyleng;return BRAKR;}
":" {rechercher(yytext, "Separateur", 0, "", 3); Col += yyleng;return DOUBLPTS;}
";" {rechercher(yytext, "Separateur", 0, "", 3); Col += yyleng;return PTV;}

{Comment1} {printf("commentaire une suele ligne \n");}
{Comment2} {printf("commentaires multi-lignes \n");nb_ligne++;}

[ \t]+ {colonne +=yyleng;}
\n {ligne++; colonne=1};

. { printf("Erreur lexicale à la ligne %d, colonne %d : caractère inattendu '%s'\n", nb_ligne, colonne, yytext); return ERREUR; }
