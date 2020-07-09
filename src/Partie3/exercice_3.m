clear;
close all;
load donnees;
load exercice_1;
figure('Name','Image tiree aleatoirement','Position',[0.2*L,0.2*H,0.6*L,0.5*H]);

% Seuil de reconnaissance a regler convenablement
s = 6.0e+03;

% Pourcentage d'information 
per = 0.95;

% Tirage aleatoire d'une image de test :
individu = randi(37);
individu = 4;
posture = randi(6);
posture = 6;
chemin = './Images_Projet_2020';
fichier = [chemin '/' num2str(individu+3) '-' num2str(posture) '.jpg']
Im=importdata(fichier);
I=rgb2gray(Im);
I=im2double(I);
image_test=I(:)';
 

% Affichage de l'image de test :
colormap gray;
imagesc(I);
axis image;
axis off;

% Nombre N de composantes principales a prendre en compte 
% [dans un second temps, N peut etre calcule pour atteindre le pourcentage
% d'information avec N valeurs propres] :
N = 8;

% N premieres composantes principales des images d'apprentissage :
C = X_c*W;
C_N = C(:,1:N);

% N premieres composantes principales de l'image de test :
C_test = (image_test-individu_moyen)*W;
C_test_N = C_test(:,1:N);

% Determination de l'image d'apprentissage la plus proche (plus proche voisin) :
ecarts_carre = (C_N-repmat(C_test_N,n,1)).^2;
d = sqrt(sum(ecarts_carre,2));
[d_min,indice] = min(d);

% Affichage du resultat :
if d_min<s
	individu_reconnu = numeros_individus(ceil(indice/nb_postures));
	title({['Posture numero ' num2str(posture) ' de l''individu numero ' num2str(individu+3)];...
		['Je reconnais l''individu numero ' num2str(individu_reconnu+3)]},'FontSize',20);
else
	title({['Posture numero ' num2str(posture) ' de l''individu numero ' num2str(individu+3)];...
		'Je ne reconnais pas cet individu !'},'FontSize',20);
end
