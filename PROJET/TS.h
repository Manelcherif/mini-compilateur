/**************** CREATION DE LA TABLE DES SYMBOLES ******************/
/*** Étape 1 : Définition des structures de données ***/
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

// Structure de la table des symboles (IDFs et constantes)
typedef struct {
    int state;            // Indique si la case est occupée (1) ou libre (0)
    char name[50];        // Nom de l'entité (variable, constante)
    char code[20];        // Code de l'entité (IDF, CONST, etc.)
    char type[20];        // Type (NUM, REAL, TEXT)
    char val[50];         // Valeur (pour les constantes ou affectations)
} TypeTS;

// Table des mots-clés et séparateurs
typedef struct {
    int state;            // État : 1 occupé, 0 libre
    char name[20];        // Nom du mot-clé ou séparateur
    char type[20];        // Code associé (e.g., MOTCLE, SEP)
} TypeSM;

// Déclaration des tables
TypeTS TS[200];               // Table des symboles (IDFs et constantes)
TypeSM tabM[50];  // Table des mots-clés
TypeSM tabS[50];  // Table des séparateurs

// Compteurs globaux
int cpt = 0;     // Compteur pour TS
int cptm = 0;    // Compteur pour tabM
int cpts = 0;    // Compteur pour tabS

// ----------------Étape 2 : Initialisation 
void initialization() {
    for (int i = 0; i < 200; i++) {
        TS[i].state = 0;
    }
    for (int i = 0; i < 50; i++) {
        tabM[i].state = 0;
        tabS[i].state = 0;
    }
    cpt = cptm = cpts = 0;
}

//------------------Étape 3 : Insertion 
void inserer(char entite[], char code[], char type[], char val[], int i, int y) {
    switch (y) {
        case 1: // Table des symboles (IDFs et constantes)
            TS[i].state = 1;
            strcpy(TS[i].name, entite);
            strcpy(TS[i].code, code);
            strcpy(TS[i].type, type);
            strcpy(TS[i].val, val);
            cpt++;
            break;

        case 2: // Table des mots-clés
            tabM[i].state = 1;
            strcpy(tabM[i].name, entite);
            strcpy(tabM[i].type, code);
            cptm++;
            break;

        case 3: // Table des séparateurs
            tabS[i].state = 1;
            strcpy(tabS[i].name, entite);
            strcpy(tabS[i].type, code);
            cpts++;
            break;

        default:
            printf("Erreur : type de table non reconnu.\n");
    }
}
//----------------- Étape 4 : Recherche 
void rechercher(char entite[], char code[], char type[], char val[], int y) {
    int i;
    switch (y) {
      case 1: 
        for (i=0;((i<200)&&(TS[i].state==1))&&(strcmp(entite,TS[i].name)!=0);i++); 
        if(i<200 && strcmp(entite,TS[i].name)!=0)
        { inserer(entite,code,type,val,i,1); 
        }else printf(">>>> L'entite %s existe deja \n",entite);
        break;

   case 2: //table des mots clés
       
       for (i=0;((i<50)&&(tabM[i].state==1))&&(strcmp(entite,tabM[i].name)!=0);i++); 
       if(i<50 && strcmp(entite,TS[i].name)!=0)
          inserer(entite,code,type,val,i,2);
        else
          printf(">>>> L'entite %s existe deja \n",entite);
        break; 
    
   case 3: //Table des séparateurs
        for (i=0;((i<50)&&(tabS[i].state==1))&&(strcmp(entite,tabS[i].name)!=0);i++); 
        if(i<50 && strcmp(entite,TS[i].name)!=0)
         inserer(entite,code,type,val,i,3);
        else
   	       printf(">>>> L'entite %s existe deja \n",entite);
        break;
  }
}

/*********************** Étape 5 : Affichage *************************/
void afficher() {
    // Table des symboles
    printf("/*************** Table des symboles IDF et CONST ***************/\n");
    printf("____________________________________________________________________\n");
    printf("| Nom      | Code      | Type      | Valeur     |\n");
    printf("____________________________________________________________________\n");
    for (int i = 0; i < cpt; i++) {
        if (TS[i].state == 1) {
            printf("| %-8s | %-9s | %-9s | %-9s |\n", TS[i].name, TS[i].code, TS[i].type, TS[i].val);
        }
    }
    printf("\n");

    // Table des mots-clés
    printf("/*************** Table des mots-clés ***************/\n");
    printf("_____________________________\n");
    printf("| Nom      | Code      |\n");
    printf("_____________________________\n");
    for (int i = 0; i < cptm; i++) {
        if (tabM[i].state == 1) {
            printf("| %-8s | %-9s |\n", tabM[i].name, tabM[i].type);
        }
    }
    printf("\n");

    // Table des séparateurs
    printf("/*************** Table des séparateurs ***************/\n");
    printf("_____________________________\n");
    printf("| Nom      | Code      |\n");
    printf("_____________________________\n");
    for (int i = 0; i < cpts; i++) {
        if (tabS[i].state == 1) {
            printf("| %-8s | %-9s |\n", tabS[i].name, tabS[i].type);
        }
    }
    printf("\n");
}