using LinearAlgebra
using Plots
using PyPlot
using Statictics

## Utilisation de l'ACP pour detecter deux classes

# Creation d'un echantillon contenant deux classes que nous allons
# retrouver via l'ACP
nb_indiv1 = 100
nb_indiv2 = 150
nb_indiv = nb_indiv1+nb_indiv2;
nb_param = 30
# Creation de la premiere classe autour de l'element moyen -.5*(1 .... 1)
X1 = 3*rand(nb_indiv1,nb_param)
X1 = X1 - 0.5*ones(nb_indiv1,1)*ones(1,nb_param)
# Creation de la premiere classe autour de l'element moyen + (1 .... 1)
X2 = 3*rand(nb_indiv2,nb_param)
X2 = X2 + 1*ones(nb_indiv2,1)*ones(1,nb_param)
# Creation du tableau des donnees (concatenation des deux classes) 
# et du tableau centr� des donnees
X = [X1;X2]

println(" ** A COMPLETER ** CONSIGNES EN COMMENTAIRE ** ")
###########################################################################
# CALCULER LA MATRICE DE VARIANCE/COVARIANCE DU TABLEAU DES DONNEES X ET
# LES AXES PRINCIPAUX. REORDONNER CES AXES PAR ORDRE DECROISSANT DU
# CONTRASTE QU'ILS FOURNISSENT.
# CALCULER LA MATRICE C DE L'ECHANTILLON DANS CE NOUVEAU REPERE
###########################################################################
x_mean = mean(X,1) 
Xc = X-ones(nb_indiv,1)*x_mean
S = 1/nb_indiv*(Xc'*Xc)
W,D = eigen(S)
tri = sortperm(D,rev=true)
D = D[tri]
W = W(:,tri)
C = Xc*W

println(" ** A COMPLETER ** CONSIGNES EN COMMENTAIRE ** ")
###########################################################################
# AFFICHER LA PROJECTION DES INDIVIDUS DANS X SUR LES DEUX PREMIERS AXES 
# CANONIQUES. LES INDIVIDUS DES DEUX CLASSES DOIVENT ETRE REPRESENTES PAR 
# DEUX COULEURS DIFFERENTES.
# AFFICHER LA PROJECTION DE CES MEMES INDIVIDUS SUR LES DEUX PREMIERS AXES 
# PRINCIPAUX (AVEC A NOUVEAU UNE COULEUR PAR CLASSE).
# COMMENTER.
###########################################################################
figure(1), clf, 
subplot(2,1,1)
# Affichage des donnees sur les premieres composantes canoniques :
# les individus de la premiere classe sont en rouge
plot([min(X(:,1))-1 max(X(:,1))+1],[0 0],'k-'),
plot(X(1:nb_indiv1,1),zeros(nb_indiv1,1),'r*'); 
# ceux de la seconde classe sont en bleu
plot(X(nb_indiv1+1:nb_indiv,1),zeros(nb_indiv2,1),'b*');
title("Visualisation des donnees sur les deux premiers axes canoniques")

# Affichage des donnees sur les premieres composantes principales : (m�me
# code couleur)
subplot(2,1,2)
plot([min(C(:,1))-1 max(C(:,1))+1],[0 0],'k-')
plot(C(1:nb_indiv1,1),zeros(nb_indiv1,1),'r*');
plot(C(nb_indiv1+1:nb_indiv,1),zeros(nb_indiv2,1),'b*');
title("Visulisation des donnees sur les deux premiers axes principaux")
legend("droite des reels','classe 1','classe 2")

println(" ** A COMPLETER ** CONSIGNES EN COMMENTAIRE ** ")
###########################################################################
# AFFICHER UNE FIGURE MONTRANT LE POURCENTAGE D'INFORMATION APPORTEE PAR
# CHAQUE COMPOSANTE PRINCIPALE. 
# EN ABSCISSE DOIT SE TROUVER LE NUMERO DE LA COMPOSANTE OBSERVEE, EN 
# ORDONNEE ON MONTRERA LE POURCENTAGE D'INFO QUE CONTIENT CETTE COMPOSANTE.
###########################################################################
figure(2), clf
plot(1:nb_param,D/trace(S),'r-*','linewidth',2);
title("Pourcentage d info contenue sur chaque composante ppale -- 2 classes")
xlabel('num de la comp. ppale');ylabel('pourcentage d info');

## Utilisation de l'ACP pour detecter plusieurs classes

# Dans le fichier 'jeu_de_donnees.mat' se trouvent 4 tableaux des donnees,
# pour des individus caracterises par les memes variables. On concatene 
# tableaux en un unique tableau X, et on va chercher combien de composantes
# principales il faut prendre en compte afin de detecter toutes les classes
load('quatre_classes.mat')
n1 = size(X1,1);n2 = size(X2,1);n3 = size(X3,1);n4 = size(X4,1);
n = n1+n2+n3+n4;
nb_param = size(X1,2)
X = [X1;X2;X3;X4]

println(" ** A COMPLETER ** CONSIGNES EN COMMENTAIRE ** ")
###########################################################################
# CALCULER LA MATRICE DE VARIANCE/COVARIANCE DU TABLEAU DES DONNEES X ET
# LES AXES PRINCIPAUX. REORDONNER CES AXES PAR ORDRE DECROISSANT DU
# CONTRASTE QU'ILS FOURNISSENT.
# CALCULER LA MATRICE C DE L'ECHANTILLON DANS CE NOUVEAU REPERE.
###########################################################################
x_mean = mean(X,1);
Xc = X-ones(n,1)*x_mean;
S = 1/n*(Xc'*Xc); 
[W,D] = eig(S); 
tri=sortperm(D,rev=true)
D = D[tri]
W = W(:,tri)
C = Xc*W

println(" ** A COMPLETER ** CONSIGNES EN COMMENTAIRE ** ")
###########################################################################
# AFFICHER LA PROJECTION DE XC SUR :
# - LE PREMIER AXE PRINCIPAL
# - LE DEUXIEME  AXE PRINCIPAL
# - LE TROISIEME AXE PRINCIPAL
# EN UTILISANT UNE COULEUR PAR CLASSE.
# COMBIEN DE CLASSES EST-ON CAPABLE DE DETECTER AVEC LA PREMIERE 
# COMPOSANTE, LA DEUXIEME, LA TROISIEME, PUIS LES TROIS ENSEMBLES ?
# NB : VOTRE FIGURE DOIT CORRESPONDRE A LA FIGURE 2(b) DE L'ENONCE.
###########################################################################
figure(3),clf
subplot(3,1,1)
plot([min(C(:,1))-0.5 max(C(:,1))+0.5],[0 0],'k-'), 
plot(C(1:n1,1),zeros(1,n1),'r*'); 
plot(C(n1+1:n1+n2,1),zeros(1,n2),'b*')
plot(C(n1+n2+1:n1+n2+n3,1),zeros(1,n3),'g*')
plot(C(n1+n2+n3+1:n1+n2+n3+n4,1),zeros(1,n4),'m*');
title("1ere composante ppale")

subplot(3,1,2)
plot([min(C(:,2))-0.5 max(C(:,2))+0.5],[0 0],'k-'), 
plot(C(1:n1,2),zeros(1,n1),'r*'); 
plot(C(n1+1:n1+n2,2),zeros(1,n2),'b*')
plot(C(n1+n2+1:n1+n2+n3,2),zeros(1,n3),'g*')
plot(C(n1+n2+n3+1:n1+n2+n3+n4,2),zeros(1,n4),'m*');
title("2eme composante ppale")

subplot(3,1,3)
plot([min(C(:,3))-0.5 max(C(:,3))+0.5],[0 0],'k-'), 
plot(C(1:n1,3),zeros(1,n1),'r*'); 
plot(C(n1+1:n1+n2,3),zeros(1,n2),'b*')
plot(C(n1+n2+1:n1+n2+n3,3),zeros(1,n3),'g*')
plot(C(n1+n2+n3+1:n1+n2+n3+n4,3),zeros(1,n4),'m*');
title("3eme composante ppale")

println(" ** A COMPLETER ** CONSIGNES EN COMMENTAIRE ** ")
###########################################################################
# AFFICHER LES DEUX PREMIERES COMPOSANTES PRINCIPALES DE X DANS LE PLAN, 
# PUIS AFFICHER LES TROIS PREMIERES COMPOSANTES PRINCIPALES DE X DANS 
# L'ESPACE. UTILISER UNE COULEUR PAR CLASSE. 
# COMBIEN DE CLASSES PEUT-ON DETECTER DANS LE PLAN ? DANS L'ESPACE ?
# NB : VOS FIGURES DOIVENT CORRESPONDRE AUX FIGURES 2(c) ET (d) DE L'ENONCE 
###########################################################################
figure(4), clf, 
plot(C(1:n1,1),C(1:n1,2),'r*'); 
plot(C(n1+1:n1+n2,1),C(n1+1:n1+n2,2),'b*')
plot(C(n1+n2+1:n1+n2+n3,1),C(n1+n2+1:n1+n2+n3,2),'g*')
plot(C(n1+n2+n3+1:n1+n2+n3+n4,1),C(n1+n2+n3+1:n1+n2+n3+n4,2),'m*');
title("Proj. des donnees sur les deux 1ers axes ppaux")
legend("ind. de la classe 1','ind. de la classe 2','ind. de la classe 3','ind. de la classe 4")

figure(5),clf, 
plot3(C(1:n1,1),C(1:n1,2),C(1:n1),'r*')
plot3(C(n1+1:n1+n2,1),C(n1+1:n1+n2,2),C(n1+1:n1+n2,3),'b*');
plot3(C(n1+n2+1:n1+n2+n3,1),C(n1+n2+1:n1+n2+n3,2),C(n1+n2+1:n1+n2+n3,3),'g*');
plot3(C(n1+n2+n3+1:n1+n2+n3+n4,1),C(n1+n2+n3+1:n1+n2+n3+n4,2),C(n1+n2+n3+1:n1+n2+n3+n4,3),'m*');
legend("ind. de la classe 1','ind. de la classe 2','ind. de la classe 3','ind. de la classe 4")
title("Proj. des donnees sur 3 1ers axes ppaux")

println(" ** A COMPLETER ** CONSIGNES EN COMMENTAIRE ** ")
###########################################################################
# AFFICHER UNE FIGURE MONTRANT LE POURCENTAGE D'INFORMATION APPORTEE PAR
# CHAQUE COMPOSANTE PRINCIPALE. 
# EN ABSCISSE DOIT SE TROUVER LE NUMERO DE LA COMPOSANTE OBSERVEE, EN 
# ORDONNEE ON MONTRERA LE POURCENTAGE D'INFO QUE CONTIENT CETTE COMPOSANTE.
###########################################################################
figure(6),clf
plot(1:nb_param,D/trace(S),'r-*','linewidth',2)
title("Pourcentage d info contenue sur chaque composante ppale -- 4 classes")
xlabel("num de la comp. ppale");
ylabel("pourcentage d info");

println(" ** A COMPLETER ** CONSIGNES EN COMMENTAIRE ** ")
###########################################################################
# COMPARER CETTE FIGURE AVEC LA MEME FIGURE OBTENUE POUR LA CLASSIFICATION
# EN DEUX GROUPES. 
# COMMENTER.
###########################################################################

