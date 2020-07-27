using LinearAlgebra
using Statistics
using JLD2
using Plots

#taille_ecran = get(0,'ScreenSize');
#L = taille_ecran(3);
#H = taille_ecran(4);

@load "src/Partie3/donnees.jld2"
#figure('Name','Individu moyen et eigenfaces','Position',[0,0,0.67*L,0.67*H]);

# Calcul de l'individu moyen :
individu_moyen = mean(X,dims=1)

# Centrage des donnees :
X_c2 = X .- individu_moyen # extension automatique ?

X_c = X - ones(n) * individu_moyen

# Calcul de la matrice Sigma_2 (de taille n x n) [voir Annexe 1 pour la nature de Sigma_2] :
Sigma_2 = X_c*X_c'/n

# Calcul des vecteurs/valeurs propres de la matrice Sigma_2 :
D,V = eigen(Sigma_2)


# Tri par ordre decroissant des valeurs propres de Sigma_2 :
indices = sortperm(D, rev=true)
valeurs_propres_triees = D[indices]

# Tri des vecteurs propres de Sigma_2 dans le meme ordre :
V = V[:, indices]

# Elimination du dernier vecteur propre de Sigma_2 :
Y = V[:,1:end-1]

# Vecteurs propres de Sigma (deduits de ceux de Sigma_2) :
W = X_c'*Y

# Normalisation des vecteurs propres de Sigma
# [les vecteurs propres de Sigma_2 sont normalis??s

# mais le calcul qui donne W, les vecteurs propres de Sigma,
# leur fait perdre cette propri??t??] :
normes_eigenfaces = sqrt(sum(W.^2))
W = W./(ones(p)*normes_eigenfaces)


# Affichage de l'individu moyen et des eigenfaces sous forme d'images :
plt = Plots.plot(layout=(nb_individus,nb_postures),showaxis = false)

img = reshape(individu_moyen,nb_lignes,nb_colonnes)
Plots.plot!(Gray.(img),title="Individu moyen",subplot=1)

for k = 1:n-1
	img = reshape(W[:,k],nb_lignes,nb_colonnes)
	Plots.plot!(Gray.(img),title="Eigenface-"*string(k),subplot=k+1)
	display(plt)
end

@save "src/Partie3/exercice_1.jld2" W valeurs_propres_triees normes_eigenfaces Sigma_2 X_c2 Y
#=
plt = Plots.plot(layout=(nb_individus,nb_postures),showaxis = false)
# Affichage des images (un individu par ligne, une posture par colonne) :
for l = 1:n
	j = numeros_individus[Int(floor((l-1)/nb_postures)+1)]
	k = numeros_postures[Int(mod((l-1),nb_postures)+1)]
	img = reshape(X[l,:],nb_lignes,nb_colonnes,3)
	#subplot(nb_individus,nb_postures,l)
	Plots.plot!(float2im(img),title="Ind. "*string(j)*", Post."*string(k))
    display(plt)
end
 =#