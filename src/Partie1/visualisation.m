clear variables; close all; clc;
% Visualiser un individu de taille 1 :
x = rand(1); % generation d'un element aleatoire par une distribution uniforme
figure(1),clf, 
plot(0,0,'ko','linewidth',2)
hold on,plot([0 1.5*x],[0 0],'k-')
hold on, plot(x,0,'r*','linewidth',3)
legend('origine du repere','vecteur de base','individu');
title('un nombre sur la droite des reels');

% Visualiser un individu de taille 2 :
x = rand(1,2); % generation d'une matrice a une ligne et deux colonnes 
% -- et donc d un veteur ligne -- par une distribution uniforme
figure(2),clf, plot(x(1),x(2),'r*','linewidth',3);grid on
title('un element de R2')

% Visualiser un individu de taille 3 :
x = rand(1,3);% generation d'une matrice a une ligne et trois colonnes 
% -- et donc d un veteur ligne -- par une distribution uniforme
figure(3),clf, plot3(x(1),x(2),x(3),'r*','linewidth',3);grid on
title('un element de R3')

nb_indiv = 10;

disp(' ** A COMPLETER ** CONSIGNES EN COMMENTAIRE ** ')
x = rand(1,nb_indiv); % GENERER ALEATOIREMENT DIX NOMBRES SUIVANT UNE DB UNIFORME
% AFFICHER CES NOMBRES ET L'ELEMENT MOYEN SUR LA DROITE DES REELS
x_mean = mean(x);
figure(11),clf
plot(0,0,'ko','linewidth',2)
hold on,plot([0 1.5*max(x)],[0 0],'k-')
hold on, plot(x,zeros(1,nb_indiv),'r*',x_mean(1),0,'b+','linewidth',3);grid on
legend('origine du repere','vecteur de base','individus','element moyen');
title('des nombres sur la droite des reels');

disp(' ** A COMPLETER ** CONSIGNES EN COMMENTAIRE ** ')
x = randn(2,nb_indiv); % GENERER ALEATOIREMENT DIX VECTEURS DE TAILLE 2 SUIVANT UNE DB GAUSSIENNE 
% DE MOYENNE 0 ET D ECART TYPE 1
x_mean = mean(x,2);
figure(12), clf % AFFICHER CES VECTEURS ET L'ELEMENT MOYEN DANS LE PLAN
plot(x(1,:),x(2,:),'r*',x_mean(1),x_mean(2),'b+','linewidth',3);grid on
legend('individus','element moyen')
title('des elements de R2')

disp(' ** A COMPLETER ** CONSIGNES EN COMMENTAIRE ** ')
x = 3*randn(3,nb_indiv)+2; % GENERER ALEATOIREMENT DIX VECTEURS DE TAILLE 3 SUIVANT UNE DB GAUSSIENNE 
% DE MOYENNE 2 ET D ECART TYPE 3
x_mean = mean(x,2);
figure(13), clf % AFFICHER CES VECTEURS ET L'ELEMENT MOYEN DANS L ESPACE
plot3(x(1,:),x(2,:),x(3,:),'r*',x_mean(1),x_mean(2),x_mean(3),'b+','linewidth',3);grid on
legend('individus','element moyen')
title('des elements de R3')
