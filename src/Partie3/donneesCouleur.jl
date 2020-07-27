using Images
using Plots
using JLD2

include("im2float.jl")
include("float2im.jl")
# Choix des images parmi les 37 individus et 6 postures faciales :
numeros_individus = [1 3 5 6]
numeros_postures = [ 2 4 5 ]

# Chargement et conversion des images
chemin = "src/Partie3/Images_Projet_2020"
X=[]
for i=numeros_individus
     for j=numeros_postures
        fichier = chemin*"/"*string(i+3)*"-"*string(j)*".jpg"
        Im = load(fichier)
        I = im2float(Im)
        r = I[:,:,1]
        v = I[:,:,2]
        b = I[:,:,3]
        if X==[]
            global X = [r[:]' v[:]' b[:]']
        else
            global X = [X;r[:]' v[:]' b[:]']
        end
    end
end



# # Nombre de lignes n de X (nombre d'images selectionnees) :
 nb_individus = length(numeros_individus)
 nb_postures = length(numeros_postures)
 n = nb_individus*nb_postures
 
 # Dimensions des images
nb_lignes= 480
nb_colonnes = 640
p = nb_lignes*nb_colonnes

plt = Plots.plot(layout=(nb_individus,nb_postures),showaxis = false)
# Affichage des images (un individu par ligne, une posture par colonne) :
for l = 1:n
	j = numeros_individus[Int(floor((l-1)/nb_postures)+1)]
	k = numeros_postures[Int(mod((l-1),nb_postures)+1)]
	img = reshape(X[l,:],nb_lignes,nb_colonnes,3)
	#subplot(nb_individus,nb_postures,l)
	Plots.plot!(float2im(img),subplot=l,title="Ind. "*string(j)*", Post."*string(k))
    display(plt)
end

@save "src/Partie3/donneesCouleur.jld2" X numeros_individus numeros_postures n p nb_lignes nb_colonnes chemin