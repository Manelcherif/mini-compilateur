%{

    int nb_ligne=1;
    int colonne = 1;
%}
lettre [a-zA-Z]
chiffre [0-9]
IDF {lettre}({lettre}|{chiffre})*
NUM {chiffre}*
REAL {chiffre}*"."{chiffre}* 
TEXT \"[^\"]*\"
%%

{IDF} {printf("idf"), return IDF;}
{NUM} { printf("num") ,return NUM;}
{REAL}{printf("real"), return REAL;}
{TEXT}{printf("text"), return TEXT;}

/*mots cles*/
"DEBUT" {return DEBUT;}
"FIN" {return FIN;}
"EXECUTION"{return EXECUTION;}
"FIXE" {return FIXE;}
"SI" {return SI;}
"SINON" {return SINON;}
"ALORS" {return ALORS;}
"TANTQUE" {return TANTQUE;}
"FAIRE" {return FAIRE;}
"NUM" {return entier;}
"REAL" {return reel ;}
"TEXT" {return text;}
"affiche" {return AFFICHE;}
"lire" {return LIRE;}
 
/*les commentaire*/
"--"[^#]*"##" {/* commentaire une suele ligne  */}
"\{-"([^-]|"-"|[^-}])*"-}" { /*commentaires multi-lignes */ }

/* operateurs*/
"<-" {return AFF;}
"+"{return PLUS;}
"-"{return MOINS;}
"*" {return MULT;}
"/" {return DIV;}
"="{return EGAL;}
"!="{return DIFF;}
"<"{return INF;}
"<="{return INFEGAL;}
">"{return SUP;}
">="{return SUPEGAL;}
"ET"{return ET;}
"OU" {return OU;}
"NON" {return NON;}
"{" {return BRAKL;}
"}"{return BRAKR;}
":" {return DOUBLPTS;}
";" {return PTSV;}

[ \t]+ {colonne +=yyleng;}
\n {ligne++; colonne=1};

. { printf("Erreur lexicale à la ligne %d, colonne %d : caractère inattendu '%s'\n", nb_ligne, colonne, yytext); return ERREUR; }


%%
int main(){
    yylex();
    return 0;
}