using LinearAlgebra
using Plots
using PyPlot
using Statistics
using JLD2

# la fonction Pause
Pause(text) = (println(stdout, text); read(stdin, 1); nothing)

close(1);close(2);close(3);close(4);close(5);close(6);
close(7);close(8);close(9);close(10);close(11);
close(12);close(13);close(14);close(15);close(16)

# Exemple de script pour trouver les classes d'individus dans dataset
@load "src/Partie1/dataset.jld2"
# 1 -Faire l'ACP
nb_indiv,nb_param = size(X)
x_mean = mean(X,dims=1)
Xc = X-ones(nb_indiv)*x_mean 
S = 1/nb_indiv*(Xc'*Xc); D,W = eigen(S); tri=sortperm(D,rev=true)
W = W[:,tri]
C = Xc*W
# Avec l'observation du pourcentage de trace fourni par les valeurs propres,
# on voit qu'il faut 6 axes principaux pour avoir un bon niveau
# d'info.
figure(1)
trace_S=sum(diag(S))
PyPlot.plot(1:nb_param,D/trace_S,"r-*")
xlabel("num de la composante")
ylabel("pourcentage d info")
title("Pourcentage d info apportee par les x premieres comp. ppales")

Pause("tapez entrée pour continuer")

# 2 - On observe donc sur les 8 premiers axes principaux (les 2 derniers axes 
# n'apportent aucune info. Je les affiche pour mettre en avant le ph�nom�ne)
figure(2)
for ax in 1:8
    subplot(4,2,ax)
    PyPlot.plot([minimum(C[:,ax])-1, maximum(C[:,ax])+1],[0, 0],"k-")
    PyPlot.plot(C[:,ax],zeros(nb_indiv),"r*")
    title("axe "*string(ax))
end

# On observe des separations nettes sur ces axes. 
# Il va donc falloir trouver les classes correspondantes.

# Sur le premier axe, on distingue 4 groupes : 
# 1) les coordonnees du premier groupe sont <-8
# 2) les coordonnees du second sont entre -8 et 3
# 3) les coordonnees du troisieme groupe sont entre 3 et 15
# 4) les coordonnees du quatrieme groupe sont >15
C1 = findall(C[:,1] .< -8) # Dans C1, on a les indices des elements de la premiere
# colonne de C qui sont <-8
C2 = findall(C[:,1] .< 3); C2 = setdiff(C2,C1) # Dans C2,on a les indices des 
# elements de la premiere premiere colonne de C qui sont <3 et >-8
C3 = findall(C[:,1] .< 15); C3 = setdiff(C3,[C1;C2]) # Dans C3, on a les indices 
# des elements de la premiere de la premiere colonne de C qui sont <15 et
# >3
C4 = findall(C[:,1] .> 15) # Dans C4, on a les indices des elements de la premiere
# colonne de C qui sont >15
# Si tout va bien, C1,C2,C3,C4 forment une partition de 1:nb_indiv: c'est
# ce qu'on vérifie ici
if length(setdiff(sort([C1;C2;C3;C4]),1:nb_indiv)) > 0
    println("something wrong happend")
end

Pause("tapez entrée pour continuer")

# Dans une nouvelle figure, on affiche avec des couleurs le partitionnement
# sur l'axe etudi�, pour v�rifier qu'on ne s'est pas tromper dans la 
# m�thodologie, puis on observe ce partitionnement sur un ou plusieurs
# autres axes, pour mettre en �vidence l'information suppl�mentaire; c'est 
# � dire des classes qu'on pourrait sur-couper 
figure(3)
for ax in 1:2
    subplot(2,1,ax)
    PyPlot.plot([minimum(C[:,ax])-1, maximum(C[:,ax])+1],[0, 0],"k-")
    PyPlot.plot(C[C1,ax],zeros(length(C1)),"r*")
    PyPlot.plot(C[C2,ax],zeros(length(C2)),"b*")
    PyPlot.plot(C[C3,ax],zeros(length(C3)),"m*")
    PyPlot.plot(C[C4,ax],zeros(length(C4)),"g*")
    title("axe "*string(ax))
end

Pause("tapez entrée pour continuer")

# Sur cette figure 3 on observe que la classe C2 contient en fait deux
# classes. On decoupe donc C2
C5 = findall(C[:,2] .< -15)
C2 = setdiff(C2,C5)
if length(setdiff(sort([C1;C2;C3;C4;C5]),1:nb_indiv)) > 0
    println("something wrong happend")
end
# ax = 2 # On refait la meme chose qu'avec la figure 3 sur une nouvelle figure

# ax = 3 # Cette fois-ci, la composante principale suivante ne nous permet pas de 
# sur-decouper nos classes...

# ax = 4 # ...On passe donc a la quatrieme

figure(4)

for ax in 2:4
    subplot(3,1,ax-1)
    PyPlot.plot([minimum(C[:,ax])-1, maximum(C[:,ax])+1],[0, 0],"k-")
    PyPlot.plot(C[C1,ax],zeros(length(C1)),"r*")
    PyPlot.plot(C[C2,ax],zeros(length(C2)),"b*")
    PyPlot.plot(C[C3,ax],zeros(length(C3)),"m*")
    PyPlot.plot(C[C4,ax],zeros(length(C4)),"g*")
    PyPlot.plot(C[C5,ax],zeros(length(C5)),"k*")
    title("axe "*string(ax))
end

Pause("tapez entrée pour continuer")

# Sur l'axe 4 on voit que C1 est partitionnable :
C6 = findall(C[:,4] .< -10); C1 =setdiff(C1,C6)
if length(setdiff(sort([C1;C2;C3;C4;C5;C6]),1:nb_indiv)) > 0
    println("something wrong happend")
end
# On reitere l'operation des figures 3 et 4 avec la figure 5
figure(5)
for i in 1:2
    ax = 2 + 2 * i 
    subplot(2,1,i)
    PyPlot.plot([minimum(C[:,ax])-1, maximum(C[:,ax])+1],[0, 0],"k-")
    PyPlot.plot(C[C1,ax],zeros(length(C1)),"r*")
    PyPlot.plot(C[C2,ax],zeros(length(C2)),"b*")
    PyPlot.plot(C[C3,ax],zeros(length(C3)),"m*")
    PyPlot.plot(C[C4,ax],zeros(length(C4)),"g*")
    PyPlot.plot(C[C5,ax],zeros(length(C5)),"k*")
    title("axe "*string(ax))
end

# Comme precedemment, l'axe 5 ne nous apprend rien de nouveau (on ne 
# l'affiche pas). On passe donc a l'axe 6, qui montre que la classe 4 se 
# divise en 2

C7 = findall(C[:,6] .< -10); C4 = setdiff(C4,C7)
if length(setdiff(sort([C1;C2;C3;C4;C5;C6;C7]),1:nb_indiv)) > 0
    println("something wrong happend")
end

Pause("tapez entrée pour continuer")

# Apres la decouverte de C7, on n'a plus d'axe sur lequel s'appuyer pour
# decouvrir d'autres classes. On reaffiche la figure du depart (les 6
# composantes principales) avec les classes par couleur.

figure(10)
for i in 1:2
    ax = 2 + 2 * i 
    subplot(3,2,i)
    PyPlot.plot([minimum(C[:,ax])-1, maximum(C[:,ax])+1],[0, 0],"k-")
    PyPlot.plot(C[C1,ax],zeros(length(C1)),"r*")
    PyPlot.plot(C[C2,ax],zeros(length(C2)),"b*")
    PyPlot.plot(C[C3,ax],zeros(length(C3)),"m*")
    PyPlot.plot(C[C4,ax],zeros(length(C4)),"g*")
    PyPlot.plot(C[C5,ax],zeros(length(C5)),"k*")
    PyPlot.plot(C[C6,ax],zeros(length(C6)),"y*")
    PyPlot.plot(C[C7,ax],zeros(length(C7)),"c*")
    title("axe "*string(ax))
end

Pause("tapez entrée pour continuer")

# A la fin de cette premi�re �tape, on a donc trouv� 7 classes. En v�rit�
# il y en a huit � voir. Mais pour les voir il faut restreindre les
# matrices aux blocs deja trouv�es. Je ne compte pas que les �tudiants aient 
# cette d�marche. Il s'agit surtout d'amuser les meilleurs d'entre eux.
# Voici cependant la mani�re dont ils devraient proc�der
println("Fin de l analyse de X : 7 classes trouvees")
# Peut-on d�couper C1 ?
X1 =X[C1,:]
nb_indiv,nb_param = size(X1)
x_mean = mean(X1,dims=1)
Xc = X1-ones(nb_indiv)*x_mean
S = 1/nb_indiv*(Xc'*Xc); D,W = eigen(S); tri=sortperm(D,rev=true)
W = W[:,tri]
C = Xc*W
# Avec cette figure, il est clair que rien ne sert d'aller voir plus loin
# que la premiere composante ppale
figure(11)
trace_S = sum(diag(S))
PyPlot.plot(1:nb_param, D / trace_S,"r-*")

Pause("tapez entrée pour continuer")

# On affiche quand meme la deuxieme, par acquis de conscience, et il est
# clair qu'il n'y a plus d'info sur une eventuelle classif � soutirer des
# axes suivants

figure(12)

for ax in 1:2
    subplot(2,1,ax)
    PyPlot.plot([minimum(C[:,ax])-1, maximum(C[:,ax])+1],[0, 0],"k-")
    PyPlot.plot(C[:,ax],zeros(nb_indiv),"r*")
    title("axe "*string(ax))
end
# C1 se sous-divise donc :
C8 = findall(C[:,1] .> 0)
C8 = C1[C8]
C1 = setdiff(C1,C8)
println("Fin de l analyse de X(C1,:) :  decoupage de C1 en 2 classes : newC1 et C8")

Pause("tapez entrée pour continuer")
for i in 1:8
    if i == 1
        # Peut-on decouper C1 ?
        X1 = X[C1,:]
    elseif i == 2
        # Peut-on decouper C2 ?
        X1 = X[C2,:]
    elseif i == 3
        # Peut-on decouper C3 ?
        X1 = X[C3,:]
    elseif i == 4
        # Peut-on decouper C4 ?
        X1 = X[C4,:]
    elseif i == 5
        # Peut-on decouper C5 ?
        X1 = X[C5,:]
    elseif i == 6
        # Peut-on decouper C6 ?
        X1 = X[C6,:]
    elseif i == 7
        # Peut-on decouper C7 ?
        X1 = X[C7,:]
    else
        # Peut-on decouper C8 ?
        X1 = X[C8,:]
    end
    if (size(X1)[1])==0 # si X1 est vide
        continue
    end 
    nb_indiv,_= size(X1)
    x_mean = mean(X1,dims=1)
    Xc = X1-ones(nb_indiv)*x_mean
    S = 1/nb_indiv*(Xc'*Xc); D,W = eigen(S); tri=sortperm(D,rev=true)
    W = W[:,tri]
    C = Xc*W
    figure(12+i)
    ax = 1
    PyPlot.plot([minimum(C[:,ax])-1, maximum(C[:,ax])+1],[0, 0],"k-")
    PyPlot.plot(C[:,ax],zeros(nb_indiv),"r*")
    title("axe "*string(i))
    println("Fin de l analyse de X[ewC"*string(ax)*",:] :  pas de nouvelle coupe")
    Pause("tapez entrée pour continuer")
end