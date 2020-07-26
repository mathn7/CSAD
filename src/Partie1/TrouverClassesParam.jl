using LinearAlgebra
using Plots
using PyPlot
using Statistics
using JLD2


close(1);close(2);close(3);close(4);close(5);close(6);
close(7);close(8);close(9);close(10);close(11);
close(12);close(13);close(14);close(15);close(16)

# les explications sont donnees dans l'autre fichier '(TrouverClassesIndiv)
# donc ici je montre juste rapidement comment obtenir les 6 classes de
# parametres

# Exemple de script pour trouver les classes d'individus dans dataset
@load "src/Partie1/dataset.jld2"
# 1 - ACP
X = X'
nb_indiv,nb_param = size(X)
x_mean = mean(X,dims=1)
Xc = X-ones(nb_indiv)*x_mean 
S = 1/nb_indiv*(Xc'*Xc); D,W = eigen(S); tri=sortperm(D,rev=true)
D1 = D[tri]
W = W[:,tri]
C = Xc*W

# Avec l'observation du pourcentage de trace fourni par les valeurs propres,
# on voit qu'il faut minimum 5 axes principaux pour avoir un bon niveau
# d'info. On envisage donc autour de sept classes
figure(1)
trace_S = sum(diag(S))
PyPlot.plot(1:nb_param,D/trace_S,"r-*",linewidth=2)

# 2 - On observe donc sur les 6 premiers axes principaux
figure(2)
for ax in 1:6
    subplot(3,2,ax)
    PyPlot.plot([minimum(C[:,ax])-1, maximum(C[:,ax])+1],[0, 0],"k-")
    PyPlot.plot(C[:,ax],zeros(nb_indiv),"r*")
    title("axe "*string(ax))
end

# Decoupage en 3 classes de la premiere composante
C1 = findall(C[:,1] .< -15)
C2 = findall(C[:,1] .< 5);C2 = setdiff(C2,C1)
C3 = findall(C[:,1] .> 5)
if length(setdiff(sort([C1;C2;C3]),1:nb_indiv)) > 0
    println("something wrong happend")
end


figure(3)
subplot(2,1,1)
ax = 1;
PyPlot.plot([minimum(C[:,ax])-1, maximum(C[:,ax])+1],[0, 0],"k-")
PyPlot.plot(C[C1,ax],zeros(length(C1)),"r*")
PyPlot.plot(C[C2,ax],zeros(length(C2),1),"b*")
PyPlot.plot(C[C3,ax],zeros(length(C3),1),"g*")
title("axe 1")

subplot(2,1,2)
ax = 2;
PyPlot.plot([minimum(C[:,ax])-1, maximum(C[:,ax])+1],[0, 0],"k-")
PyPlot.plot(C[C1,ax],zeros(length(C1)),"r*")
PyPlot.plot(C[C2,ax],zeros(length(C2)),"b*")
PyPlot.plot(C[C3,ax],zeros(length(C3)),"g*")
title("axe 2")

# C3 se decoupe en trois classes sur la deuxieme composante
C4 = findall(C[:,2] .< -15); C3 = setdiff(C3,C4)
C5 = findall(C[:,2] .> 15); C3 = setdiff(C3,C5)
if length(setdiff(sort([C1;C2;C3;C4;C5]),1:nb_indiv)) > 0
    println("something wrong happend")
end

figure(4)
subplot(2,1,1)
ax = 2;
PyPlot.plot([minimum(C[:,ax])-1, maximum(C[:,ax])+1],[0, 0],"k-")
PyPlot.plot(C[C1,ax],zeros(length(C1)),"r*")
PyPlot.plot(C[C2,ax],zeros(length(C2)),"b*")
PyPlot.plot(C[C3,ax],zeros(length(C3)),"g*")
PyPlot.plot(C[C4,ax],zeros(length(C4)),"m*")
PyPlot.plot(C[C5,ax],zeros(length(C5)),"k*")
title("axe 2")
subplot(2,1,2)
ax = 3;
PyPlot.plot([minimum(C[:,ax])-1, maximum(C[:,ax])+1],[0, 0],"k-")
PyPlot.plot(C[C1,ax],zeros(length(C1)),"r*")
PyPlot.plot(C[C2,ax],zeros(length(C2)),"b*")
PyPlot.plot(C[C3,ax],zeros(length(C3)),"g*")
PyPlot.plot(C[C4,ax],zeros(length(C4)),"m*")
PyPlot.plot(C[C5,ax],zeros(length(C5)),"k*")
title("axe 3 ")
# C1 se decoupe en 2 classes sur la troisieme composante principale
C6 = findall(C[:,3] .< -15);C1 = setdiff(C1,C6)
if length(setdiff(sort([C1;C2;C3;C4;C5;C6]),1:nb_indiv)) > 0
    println("something wrong happend")
end

# On affiche la figure 10 : on ne peut plus decouvrir personne 
figure(10), clf
for ax in 1:6
    subplot(3,2,ax)
    PyPlot.plot([minimum(C[:,ax])-1, maximum(C[:,ax])+1],[0, 0],"k-")
    PyPlot.plot(C[C1,ax],zeros(length(C1)),"r*")
    PyPlot.plot(C[C2,ax],zeros(length(C2)),"b*")
    PyPlot.plot(C[C3,ax],zeros(length(C3)),"g*")
    PyPlot.plot(C[C4,ax],zeros(length(C4)),"k*")
    PyPlot.plot(C[C5,ax],zeros(length(C5)),"m*")
    PyPlot.plot(C[C6,ax],zeros(length(C6)),"y*")
    title("axe "*string(ax))
end

println("Fin de l analyse de Y= transpose(X) : 6 classes trouvees")

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
    else
        # Peut-on decouper C6 ?
        X1 = X[C6,:]
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
    figure(10+i)
    ax = 1
    PyPlot.plot([minimum(C[:,ax])-1, maximum(C[:,ax])+1],[0, 0],"k-")
    PyPlot.plot(C[:,ax],zeros(nb_indiv),"r*")
    title("axe "*string(i))
    println("Fin de l analyse de Y[C"*string(ax)*",:] :  pas de nouvelle coupe")
end