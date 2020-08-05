using JLD2
using PyPlot
using Statistics

@load "src/Partie3/exercice_1.jld2"
close(1);close(2)
#h = figure('Position',[0,0,0.67*L,0.67*H]);
#figure('Name','RMSE en fonction du nombre de composantes principales','Position',[0.67*L,0,0.33*L,0.3*L]);

# Calcul de la RMSE entre images originales et images reconstruites :
RMSE_max = 0

# Composantes principales des donnees d'apprentissage
C = X_c * W

for q = 1:n-1
    Cq = C[:,1:q]	# q premieres composantes principales
    Wq = W[:,1:q] # q premieres eigenfaces
    X_reconstruit = Cq*Wq' + ones(n)*individu_moyen   
    #set(h,'Name',['Utilisation des ' num2str(q) ' premieres composantes principales']);
    #colormap gray;
    #hold off;
    plt = Plots.plot(layout=(nb_individus,nb_postures),showaxis=false)
    for k = 1:n
        img = reshape(X_reconstruit[k,:],nb_lignes,nb_colonnes)
        Plots.plot!(Gray.(img),subplot=k)
        display(plt)
    end

    figure(1)
    #hold on

    ecart_quadratique_moyen = mean(mean((X-X_reconstruit).^2))
    RMSE = sqrt(ecart_quadratique_moyen)
    global RMSE_max = max(RMSE,RMSE_max)

    PyPlot.plot(q,RMSE,"r+",linewidth=8)
    axis([0, n-1, 0, 1.1*RMSE_max])
    #set(gca,fontsize=20)
    xlabel(L"q",fontsize=30)
    ylabel("RMSE",fontsize=30)
    #pause(0.01)
end
