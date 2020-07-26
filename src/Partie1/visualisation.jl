using LinearAlgebra
using PyPlot
using Statistics

close(1);close(2);close(3);close(11);close(12);close(13);

# Visualiser un individu de taille 1 :
x = rand(1) # generation d"un element aleatoire par une distribution uniforme
figure(1) 
PyPlot.plot([0],[0],"ko",linewidth=2,label="origine du repere")
PyPlot.plot([0, 1.5*x],[0, 0],"k-",label="vecteur de base")
PyPlot.plot(x,[0],"r*",linewidth=3,label="individu")
legend()
title("un nombre sur la droite des reels")

# Visualiser un individu de taille 2 :
x = rand(2,1) # generation d"une matrice a une ligne et deux colonnes 
# -- et donc d un veteur ligne -- par une distribution uniforme
PyPlot.figure(2) 
PyPlot.plot(x[1],x[2],"r*",linewidth=3) #grid on
title("un element de R2")

# Visualiser un individu de taille 3 :
x = rand(3,1) # generation d"une matrice a une ligne et trois colonnes 
# -- et donc d un veteur ligne -- par une distribution uniforme
figure(3) 
PyPlot.plot3D(x[1,:],x[2,:],x[3,:],"r*",linewidth=3) #grid on
title("un element de R3")

nb_indiv = 10

# println(" ** A COMPLETER ** CONSIGNES EN COMMENTAIRE ** ")

x = rand(nb_indiv) # GENERER ALEATOIREMENT DIX NOMBRES SUIVANT UNE DB UNIFORME
# AFFICHER CES NOMBRES ET L"ELEMENT MOYEN SUR LA DROITE DES REELS
x_mean = mean(x)
figure(11)
PyPlot.plot([0],[0],"ko",linewidth=2,label="origine du repere")
PyPlot.plot([0, 1.5*maximum(x)],[0, 0],"k-",label="vecteur de base")
PyPlot.plot(x,zeros(nb_indiv),"r*",label="individus")
PyPlot.plot([x_mean[1]],[0],"b+",linewidth=3,label="element moyen") #grid on
legend()
title("des nombres sur la droite des reels")

# println(" ** A COMPLETER ** CONSIGNES EN COMMENTAIRE ** ")

x = randn(2,nb_indiv) # GENERER ALEATOIREMENT DIX VECTEURS DE TAILLE 2 SUIVANT UNE DB GAUSSIENNE 
# DE MOYENNE 0 ET D ECART TYPE 1
x_mean = mean(x,dims=2)
figure(12) # AFFICHER CES VECTEURS ET L"ELEMENT MOYEN DANS LE PLAN
PyPlot.plot(x[1,:],x[2,:],"r*",label="individus")
PyPlot.plot(x_mean[1],x_mean[2],"b+",linewidth=3,label="element moyen") #grid on
legend()
title("des elements de R2")

# println(" ** A COMPLETER ** CONSIGNES EN COMMENTAIRE ** ")

x = 3*randn(3,nb_indiv) .+ 2 # GENERER ALEATOIREMENT DIX VECTEURS DE TAILLE 3 SUIVANT UNE DB GAUSSIENNE 
# DE MOYENNE 2 ET D ECART TYPE 3
x_mean = mean(x,dims=2)
figure(13) # AFFICHER CES VECTEURS ET L"ELEMENT MOYEN DANS L ESPACE
PyPlot.plot3D(x[1,:],x[2,:],x[3,:],"r*",label="individus")
PyPlot.plot3D(x_mean[1,:],x_mean[2,:],x_mean[3,:],"b+",linewidth=3,label="element moyen")
#grid on
legend()
title("des elements de R3")
