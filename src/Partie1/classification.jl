using LinearAlgebra
using Plots
using PyPlot
using Statistics
using JLD2

## Utilisation de l'ACP pour detecter deux classes

# Creation d'un echantillon contenant deux classes que nous allons
# retrouver via l'ACP
nb_indiv1 = 100
nb_indiv2 = 150
nb_indiv = nb_indiv1+nb_indiv2
nb_param = 30
# Creation de la premiere classe autour de l'element moyen -.5*(1 .... 1)
X1 = 3*rand(nb_indiv1,nb_param)
X1 = X1 - 0.5*ones(nb_indiv1)*ones(nb_param)'
# Creation de la premiere classe autour de l'element moyen + (1 .... 1)
X2 = 3*rand(nb_indiv2,nb_param)
X2 = X2 + 1*ones(nb_indiv2)*ones(nb_param)'
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
x_mean = mean(X,dims=1) 
Xc = X-ones(nb_indiv)*x_mean
S = 1/nb_indiv*(Xc'*Xc)
D,W = eigen(S)
tri = sortperm(D,rev=true)
D = D[tri]
W = W[:,tri]
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
close(1);close(2);close(3);close(4);close(5);close(6);
figure(1)
subplot(2,1,1)
# Affichage des donnees sur les premieres composantes canoniques :
# les individus de la premiere classe sont en rouge
PyPlot.plot([minimum(X[:,1])-1, maximum(X[:,1])+1],[0, 0],color=:cyan)
PyPlot.scatter(X[1:nb_indiv1],zeros(nb_indiv1),color=:red) 
# ceux de la seconde classe sont en bleu
PyPlot.scatter(X[nb_indiv1+1:nb_indiv,1],zeros(nb_indiv2),color=:blue)
title("Visualisation des donnees sur les deux premiers axes canoniques")

# Affichage des donnees sur les premieres composantes principales : (m�me
# code couleur)
subplot(2,1,2)
PyPlot.plot([minimum(C[:,1])-1, maximum(C[:,1])+1],[0, 0],color=:cyan,label="droite des reels")
PyPlot.scatter(C[1:nb_indiv1],zeros(nb_indiv1),color=:red,label="classe 1") 
PyPlot.scatter(C[nb_indiv1+1:nb_indiv,1],zeros(nb_indiv2),color=:blue,label="classe 2")
title("Visulisation des donnees sur les deux premiers axes principaux")
legend()

println(" ** A COMPLETER ** CONSIGNES EN COMMENTAIRE ** ")
###########################################################################
# AFFICHER UNE FIGURE MONTRANT LE POURCENTAGE D'INFORMATION APPORTEE PAR
# CHAQUE COMPOSANTE PRINCIPALE. 
# EN ABSCISSE DOIT SE TROUVER LE NUMERO DE LA COMPOSANTE OBSERVEE, EN 
# ORDONNEE ON MONTRERA LE POURCENTAGE D'INFO QUE CONTIENT CETTE COMPOSANTE.
###########################################################################
figure(2)
trace_S = sum(diag(S))
PyPlot.plot(1:nb_param,D/trace_S,"r-*")
title("Pourcentage d info contenue sur chaque composante ppale -- 2 classes")
xlabel("num de la comp. ppale")
ylabel("pourcentage d info")

## Utilisation de l'ACP pour detecter plusieurs classes

# Dans le fichier 'jeu_de_donnees.mat' se trouvent 4 tableaux des donnees,
# pour des individus caracterises par les memes variables. On concatene 
# tableaux en un unique tableau X, et on va chercher combien de composantes
# principales il faut prendre en compte afin de detecter toutes les classes
@load "src/Partie1/quatre_classes.jld2"
n1 = size(X1)[1];n2 = size(X2)[1];n3 = size(X3)[1];n4 = size(X4)[1]
n = n1+n2+n3+n4
nb_param = size(X1)[2]
X = [X1;X2;X3;X4]

println(" ** A COMPLETER ** CONSIGNES EN COMMENTAIRE ** ")
###########################################################################
# CALCULER LA MATRICE DE VARIANCE/COVARIANCE DU TABLEAU DES DONNEES X ET
# LES AXES PRINCIPAUX. REORDONNER CES AXES PAR ORDRE DECROISSANT DU
# CONTRASTE QU'ILS FOURNISSENT.
# CALCULER LA MATRICE C DE L'ECHANTILLON DANS CE NOUVEAU REPERE.
###########################################################################
x_mean = mean(X,dims=1) 
Xc = X-ones(n)*x_mean
S = 1/n*(Xc'*Xc)
D,W = eigen(S)
tri=sortperm(D,rev=true)
D = D[tri]
W = W[:,tri]
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
figure(3)
subplot(3,1,1)
PyPlot.plot([minimum(C[:,1])-0.5, maximum(C[:,1])+0.5],[0, 0],"k-") 
PyPlot.plot(C[1:n1,1],zeros(n1),"r*") 
PyPlot.plot(C[n1+1:n1+n2,1],zeros(n2),"b*")
PyPlot.plot(C[n1+n2+1:n1+n2+n3,1],zeros(n3),"g*")
PyPlot.plot(C[n1+n2+n3+1:n1+n2+n3+n4,1],zeros(n4),"m*")
title("1ere composante ppale")

subplot(3,1,2)
PyPlot.plot([minimum(C[:,2])-0.5, maximum(C[:,2])+0.5],[0, 0],"k-") 
PyPlot.plot(C[1:n1,2],zeros(n1),"r*") 
PyPlot.plot(C[n1+1:n1+n2,2],zeros(n2),"b*")
PyPlot.plot(C[n1+n2+1:n1+n2+n3,2],zeros(n3),"g*")
PyPlot.plot(C[n1+n2+n3+1:n1+n2+n3+n4,2],zeros(n4),"m*")
title("2eme composante ppale")

subplot(3,1,3)
PyPlot.plot([minimum(C[:,3])-0.5, maximum(C[:,3])+0.5],[0, 0],"k-") 
PyPlot.plot(C[1:n1,3],zeros(n1),"r*") 
PyPlot.plot(C[n1+1:n1+n2,3],zeros(n2),"b*")
PyPlot.plot(C[n1+n2+1:n1+n2+n3,3],zeros(n3),"g*")
PyPlot.plot(C[n1+n2+n3+1:n1+n2+n3+n4,3],zeros(n4),"m*")
title("3eme composante ppale")

println(" ** A COMPLETER ** CONSIGNES EN COMMENTAIRE ** ")
###########################################################################
# AFFICHER LES DEUX PREMIERES COMPOSANTES PRINCIPALES DE X DANS LE PLAN, 
# PUIS AFFICHER LES TROIS PREMIERES COMPOSANTES PRINCIPALES DE X DANS 
# L'ESPACE. UTILISER UNE COULEUR PAR CLASSE. 
# COMBIEN DE CLASSES PEUT-ON DETECTER DANS LE PLAN ? DANS L'ESPACE ?
# NB : VOS FIGURES DOIVENT CORRESPONDRE AUX FIGURES 2(c) ET (d) DE L'ENONCE 
###########################################################################
figure(4)
PyPlot.plot(C[1:n1,1],C[1:n1,2],"r*",label="ind. de la classe 1")
PyPlot.plot(C[n1+1:n1+n2,1],C[n1+1:n1+n2,2],"b*",label="ind. de la classe 2")
PyPlot.plot(C[n1+n2+1:n1+n2+n3,1],C[n1+n2+1:n1+n2+n3,2],"g*",label="ind. de la classe 3")
PyPlot.plot(C[n1+n2+n3+1:n1+n2+n3+n4,1],C[n1+n2+n3+1:n1+n2+n3+n4,2],"m*",label="ind. de la classe 4")
title("Proj. des donnees sur les deux 1ers axes ppaux")
legend()

figure(5)
PyPlot.plot3D(C[1:n1,1],C[1:n1,2],C[1:n1],"r*",label="ind. de la classe 1")
PyPlot.plot3D(C[n1+1:n1+n2,1],C[n1+1:n1+n2,2],C[n1+1:n1+n2,3],"b*",label="ind. de la classe 2")
PyPlot.plot3D(C[n1+n2+1:n1+n2+n3,1],C[n1+n2+1:n1+n2+n3,2],C[n1+n2+1:n1+n2+n3,3],"g*",label="ind. de la classe 3")
PyPlot.plot3D(C[n1+n2+n3+1:n1+n2+n3+n4,1],C[n1+n2+n3+1:n1+n2+n3+n4,2],C[n1+n2+n3+1:n1+n2+n3+n4,3],"m*",label="ind. de la classe 4")
legend()
title("Proj. des donnees sur 3 1ers axes ppaux")

println(" ** A COMPLETER ** CONSIGNES EN COMMENTAIRE ** ")
###########################################################################
# AFFICHER UNE FIGURE MONTRANT LE POURCENTAGE D'INFORMATION APPORTEE PAR
# CHAQUE COMPOSANTE PRINCIPALE. 
# EN ABSCISSE DOIT SE TROUVER LE NUMERO DE LA COMPOSANTE OBSERVEE, EN 
# ORDONNEE ON MONTRERA LE POURCENTAGE D'INFO QUE CONTIENT CETTE COMPOSANTE.
###########################################################################
figure(6)
trace_S=sum(diag(S))
PyPlot.plot(1:nb_param,D/trace_S,"r-*")
title("Pourcentage d info contenue sur chaque composante ppale -- 4 classes")
xlabel("num de la comp. ppale")
ylabel("pourcentage d info")

println(" ** A COMPLETER ** CONSIGNES EN COMMENTAIRE ** ")
###########################################################################
# COMPARER CETTE FIGURE AVEC LA MEME FIGURE OBTENUE POUR LA CLASSIFICATION
# EN DEUX GROUPES. 
# COMMENTER.
###########################################################################

