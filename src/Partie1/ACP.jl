using PyPlot
using Statistics

## Creation de 100 individus de R2 pour montrer comment s"effectue le changement de repère via l"ACP
nb_indiv = 100

# Creation d'un nuage de points de R2:
# On cree separement les coordonnees des abscisses et des ordonnees; afin 
# d"avoir un nuage plus etendu dans une dimension que dans l"autre
X1 = randn(nb_indiv,1)
X2 = 5*randn(nb_indiv,1); 
X = [X1 X2]

# on va faire "tourner" le nuage; pour que les axes de la base trouvee via
# l'ACP ne soient pas confondus avec ceux de la base canonique.
angle = pi/6; 
R = [cos(angle) -sin(angle) sin(angle) cos(angle)]; 
X = X*R; 

# On affiche le nuage de points dans le repere canonique
plt = Plots.plot!(X[:,1],X[:,2],LineWidth = 2,color =:red)

# l"ACP correspond à un changement de repere de l"espace des données : le 
# centre du repère devient l'individu moyen; les vecteurs de la base 
# maximisent la dispersion et ne sont pas correles

print(" ** A COMPLETER ** CONSIGNES EN COMMENTAIRE ** \n")
###########################################################################
# CALCULER LA MATRICE DE VARIANCE/COVARIANCE DU TABLEAU DES DONNEES X ET
# LES AXES PRINCIPAUX. REORDONNER CES AXES PAR ORDRE DECROISSANT DU
# CONTRASTE QU'ILS FOURNISSENT
# (cf - TP1 RVB)
###########################################################################
x_mean = X'*ones(nb_indiv,1)/nb_indiv;

x_mean = mean(X,1)
Xc = X-ones(nb_indiv,1)*x_mean; 
S = 1/nb_indiv*(Xc'*Xc); D,W = eigen(S) [~,tri]=sort(diag(D),'descend')
W = W[:,tri]

print(" ** A COMPLETER ** CONSIGNES EN COMMENTAIRE ** "\n)
###########################################################################
# AFFICHER LE NOUVEAU REPERE DEFINI PAR LES AXES PRINCIPAUX ET L'ELEMENT 
# MOYEN SUR LA FIGURE [1]
###########################################################################

figure(1), hold on, axis equal
plot(x_mean[1], x_mean[2],"ko",...
    [x_mean[1] 10*W[1,1]+x_mean[1]],[x_mean[2] x_mean[2]+10*W[2,1]],"k-",...
    [x_mean[1] 5*W[1,2]+x_mean[1]],[x_mean[2] x_mean[2]+5*W[2,2]],"b-','linewidth",2)
legend("nuage de points','individu moyen','premier axe principal','deuxieme axe principal")
title("Changement de repere : repere canonique VS repere principal")

## Creation de 100 individus de R10 pour montrer l"interet de projeter sur les composantes principales plutot que sur n"importe quel axe

# Creation d"un echantillon d"individus beaucoup plus disperse sur ses
# deux dernieres variables que sur les autres
X1 =  8*randn(nb_indiv,1)
X2 = 10*randn(nb_indiv,1)
X = randn(nb_indiv,8); 
X = [X,X1,X2]

disp(" ** A COMPLETER ** CONSIGNES EN COMMENTAIRE ** ")
###########################################################################
# CALCULER LA MATRICE DE VARIANCE/COVARIANCE DU TABLEAU DES DONNEES X ET
# LES AXES PRINCIPAUX. REORDONNER CES AXES PAR ORDRE DECROISSANT DU
# CONTRASTE QU'ILS FOURNISSENT.
# CALCULER LA MATRICE C DE L'ECHANTILLON X DANS CE NOUVEAU REPERE [i.e. LA 
# PROJECTION DES LIGNES DE Xc LE TABLEAU CENTRE DANS LA NOUVELLE BASE] :
# CHAQUE COLONNE DE C CORRESPOND A CE QUE L'ON APPELLE UNE COMPOSANTE
# PRINCIPALE DE X
###########################################################################
x_mean = mean(X,1)
Xc = X-ones(nb_indiv,1)*x_mean; 
S = 1/nb_indiv*(Xc"*Xc); D,W = eigen(S) [D,tri]=sort(diag(D),'descend")
W = W[:,tri]
C = Xc*W

disp(" ** A COMPLETER ** CONSIGNES EN COMMENTAIRE ** ")
###########################################################################
# SUR UNE MEME FIGURE; AFFICHER EN ROUGE LA PROJECTION DES INDIVIDUS DE Xc
# SUR LES DEUX PREMIERS AXES DE LA BASE CANONIQUE [i.e. EN UTILISANT POUR 
# CHAQUE IND. SES COEFFICIENTS DANS LES DEUX PREMIERES COLONNES DE Xc]; 
# PUIS EN BLEU LA PROJECTION DE CES INDIVIDUS SUR LES DEUX PREMIERS AXES
# PRINCIPAUX [i.e. EN UTILISANT POUR CHAQUE IND. SES COEFFICIENTS DANS LES
# DEUX PREMIERES COLONNES DE C]
# QUE REMARQUEZ-VOUS ? (A EXPLIQUER DANS LE RAPPORT)
###########################################################################

#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#
# NB : ATTENTION A BIEN AFFICHER LA PROJECTION DES INDIVIDUS DE Xc [ET NON
# DE X] SUR LES DEUX PREMIERS AXES CANONIQUES. SINON LES DEUX NUAGES DE
# POINTS NE SERONT PAS CENTRES SUR LE MEME POINT ET IL SERA PLUS DUR D'EN
# TIRER DES CONSEQUENCES
#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#
figure(2), clf()
plot(Xc[:,1],Xc[:,2],"r*',C[:,1],C[:,2],'b*"),grid on
legend("proj echantillon centre sur 2 1ers axes cqs"...
    ,"proj echantillon sur 2 1ers axes ppaux")
title("Projections sur axes canoniques VS axes principaux")

disp(" ** A COMPLETER ** CONSIGNES EN COMMENTAIRE ** ")
###########################################################################
# CALCULER L'INFORMATION -- i.e. LA PROPORTION DE CONTRASTE -- CONTENUE 
# DANS LES DEUX PREMIERES COMPOSANTES PRINCIPALES POUR L'ECHANTILLON X; VIA
# LES ELEMENTS SPECTRAUX DE LA MATRICE DE VARIANCE/COVARIANCE
###########################################################################
@sprintf("Pourcentage d info sur la premiere composante principale = %.3f\n",D[1]/trace(S))
@sprintf("Pourcentage d info sur la deuxieme composante principale = %.3f\n",D[2]/trace(S))
@sprintf("Pourcentage d info sur les deux premieres composantes    = %.3f\n",(D[1]+D[2])/trace(S))











