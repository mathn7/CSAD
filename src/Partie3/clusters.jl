using JLD2
using PyPlot
using LaTeXStrings

@load "src/Partie3/exercice_1.jld2"

#figure(name="Plan des deux premieres composantes principales")#,position=[0,0,0.67*L,0.67*H])
figure()
# Composantes principales des donnees d'apprentissage
C = X_c*W

# Affichage des deux premieres composantes principales des donnees d'apprentissage :
for i = 1:nb_individus
	lignes = Int.((i-1)*nb_postures+1:i*nb_postures)
	PyPlot.scatter(C[lignes,1],C[lignes,2],linewidth=10)#,linewidth=2) #["*" 0.5*(rand(3) .+ 1)],
end

proportion = 0.5
ecart_x = maximum(C[:,1])-minimum(C[:,1])
min_x = minimum(C[:,1])-proportion*ecart_x
max_x = maximum(C[:,1])+proportion*ecart_x
ecart_y = maximum(C[:,2])-minimum(C[:,2])
min_y = minimum(C[:,2])-proportion*ecart_y
max_y = maximum(C[:,2])+proportion*ecart_y
axis([min_x, max_x, min_y, max_y])
#axis equal
#set(gca,fontsize=20)
xlabel(L"\mathrm{C_1}",fontsize=30)
ylabel(L"\mathrm{C_2}",fontsize=30)
