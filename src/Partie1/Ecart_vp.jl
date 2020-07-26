# On verifie que dans la table de donnees X de dataset, on a bien les
# valeurs propres des deux matrices de variance/covariance � peu pres 
# égales à une multiplication par une constante pret 
using LinearAlgebra
using Statistics
using JLD2

@load "src/Partie1/dataset.jld2"
n1,n2 = size(X)
x_mean = mean(X,dims=1)
Xc = X .- x_mean
S = 1/n1*Xc'*Xc
D,W = eigen(S)
tri=sortperm(D,rev=true)
D1 = D[tri]
W1 = W[:,tri]

Y = X'
y_mean = mean(Y,dims=1) 
Yc = Y .- y_mean
S = 1 / n2 * Yc' * Yc
D,W = eigen(S)
tri=sortperm(D,rev=true)
D2 = D[tri]
W2 = W[:,tri]

n = minimum(n1,n2)

ecart_vp = (abs(n1*D1[1:n]-n2*D2[1:n]))
erreur = maximum(ecart_vp)




