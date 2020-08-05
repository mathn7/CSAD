using JLD2
using Plots
using Images

@load "src/Partie3/donnees.jld2"
@load "src/Partie3/exercice_1.jld2"

#figure('Name','Image tiree aleatoirement','Position',[0.2*L,0.2*H,0.6*L,0.5*H]);

# Seuil de reconnaissance a regler convenablement
s = 6.0e-1

# Pourcentage d'information 
per = 0.95

# Tirage aleatoire d'une image de test :
individu = 10#randi(37)
posture = 4#randi(6)
chemin = "src/Partie3/Images_Projet_2020"
fichier = chemin*"/"*string(individu+3)*"-"*string(posture)*".jpg"
Im = load(fichier)
#I = im2float(Im)
I = Gray.(Im)
image_test = I[:]'

# Nombre N de composantes principales a prendre en compte 
# [dans un second temps, N peut etre calcule pour atteindre le pourcentage
# d'information avec N valeurs propres] :
N = 8

# N premieres composantes principales des images d'apprentissage :
C = X_c*W
C_N = C[:,1:N]

# N premieres composantes principales de l'image de test :
C_test = (image_test-individu_moyen)*W
C_test_N = C_test[:,1:N]

function repmat(A,n,p)
	n1,n2 = size(A)
	result = zeros(n1*n,n2*p)
	for i in 1:n
		for j in 1:p
			result[(i-1)*n1+1:i*n1,(j-1)*n2+1:j*n2] = A
		end
	end
	return result
end
# Determination de l'image d'apprentissage la plus proche (plus proche voisin) :
ecarts_carre = (C_N-repmat(C_test_N,n,1)).^2
d = sqrt(sum(ecarts_carre))
d_min,indice = findmin(d)

# Affichage du resultat :
individu_reconnu = numeros_individus[Int(ceil(indice/nb_postures))]
if d_min < s	
	# Affichage de l'image de test :
	plt = Plots.plot(I,showaxis = false,titlefontsize=10,
	title="Posture N° "*string(posture)*" de l\'individu N° "*string(individu+3)*"\nJe reconnais l\'individu N° "*string(individu_reconnu+3))
	display(plt)
else
	# Affichage de l'image de test :
	plt = Plots.plot(I,showaxis = false,titlefontsize=10,
	title="Posture N° "*string(posture)*" de l\'individu N° "*string(individu+3)*"\nJe ne reconnais pas l\'individu N° "*string(individu_reconnu+3))
	display(plt)
end