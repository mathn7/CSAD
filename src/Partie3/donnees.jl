using Plots
using Images
using  JLD2

# Choix des images parmi les 37 individus et 6 postures faciales :
numeros_individus = [2, 4, 6, 37]
numeros_postures = [1, 2, 3, 4]

include("float2im.jl")

# Chargement et conversion des images
chemin = "src/Partie3/Images_Projet_2020"
X = []
for i=numeros_individus
     for j=numeros_postures
		fichier = chemin*"/"*string(i+3)*"-"*string(j)*".jpg"
		Im=load(fichier)
		#I=rgb2gray(Im)
		#I=im2double(I)
		I = Gray.(Im)
		if X==[]
			global X = I[:]
		else
			global X = [X I[:]]
		end
    end
end

# Nombre de lignes n de X (nombre d"images selectionnees) :
nb_individus = length(numeros_individus)
nb_postures = length(numeros_postures)
n = nb_individus*nb_postures
 
# Dimensions des images
nb_lignes = 480
nb_colonnes = 640
p = nb_lignes*nb_colonnes


# Affichage des images (un individu par ligne, une posture par colonne):
plt = Plots.plot(layout=(nb_individus,nb_postures),showaxis = false)

for l = 1:n
	j = numeros_individus[Int(floor((l-1)/nb_postures)+1)]
	k = numeros_postures[Int(mod((l-1),nb_postures)+1)]
	img = reshape(X[:,l],nb_lignes,nb_colonnes)
	#subplot(nb_individus,nb_postures,l)
	#imagesc(img)
	Plots.plot!(img,subplot=l,title="Ind:"*string(j)*", Post:"*string(k),titlefontsize=7)
	display(plt)
end

@save "src/Partie3/donnees.jld2" X nb_colonnes nb_lignes chemin n nb_individus nb_postures numeros_postures numeros_individus p