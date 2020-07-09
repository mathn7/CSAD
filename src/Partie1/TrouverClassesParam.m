% les explications sont donnees dans l'autre fichier '(TrouverClassesIndiv)
% donc ici je montre juste rapidement comment obtenir les 6 classes de
% parametres

clear variables
close all
% Exemple de script pour trouver les classes d'individus dans dataset
load('dataset.mat')
% 1 - ACP
X = X';
[nb_indiv,nb_param] = size(X);
x_mean = mean(X,1);
Xc = X-ones(nb_indiv,1)*x_mean;
S = 1/nb_indiv*(Xc'*Xc); [W,D] = eig(S); [D,tri]=sort(diag(D),'descend');
D1 =D;
W = W(:,tri);
C = Xc*W;
% Avec l'observation du pourcentage de trace fourni par les valeurs propres,
% on voit qu'il faut minimum 5 axes principaux pour avoir un bon niveau
% d'info. On envisage donc autour de sept classes
figure(1),clf
plot(1:nb_param,D/trace(S),'r-*','linewidth',2);

% 2 - On observe donc sur les 6 premiers axes principaux
figure(2), clf
ax = 1;
subplot(3,2,ax)
plot([min(C(:,ax))-1 max(C(:,ax))+1],[0 0],'k-',C(:,ax),zeros(nb_indiv,1),'r*')
title('axe 1')
ax = 2;
subplot(3,2,ax)
plot([min(C(:,ax))-1 max(C(:,ax))+1],[0 0],'k-',C(:,ax),zeros(nb_indiv,1),'r*')
title('axe 2')
ax = 3;
subplot(3,2,ax)
plot([min(C(:,ax))-1 max(C(:,ax))+1],[0 0],'k-',C(:,ax),zeros(nb_indiv,1),'r*')
title('axe 3')
ax = 4;
subplot(3,2,ax)
plot([min(C(:,ax))-1 max(C(:,ax))+1],[0 0],'k-',C(:,ax),zeros(nb_indiv,1),'r*')
title('axe 4')
ax = 5;
subplot(3,2,ax)
plot([min(C(:,ax))-1 max(C(:,ax))+1],[0 0],'k-',C(:,ax),zeros(nb_indiv,1),'r*')
title('axe 5')
ax = 6;
subplot(3,2,ax)
plot([min(C(:,ax))-1 max(C(:,ax))+1],[0 0],'k-',C(:,ax),zeros(nb_indiv,1),'r*')
title('axe 6')

% Decoupage en 3 classes de la premiere composante
C1 = find(C(:,1)<-15);
C2 = find(C(:,1)<5);C2 = setdiff(C2,C1);
C3 = find(C(:,1)>5);
if(~all(sort([C1;C2;C3])==(1:nb_indiv)'))
    disp('something wrong happend')
end


figure(3), clf
subplot(2,1,1)
ax = 1;
plot([min(C(:,ax))-1 max(C(:,ax))+1],[0 0],'k-',C(C1,ax),zeros(length(C1),1),'r*')
hold on, plot(C(C2,ax),zeros(length(C2),1),'b*')
hold on, plot(C(C3,ax),zeros(length(C3),1),'g*')
title('axe 1')
subplot(2,1,2)
ax = 2;
plot([min(C(:,ax))-1 max(C(:,ax))+1],[0 0],'k-',C(C1,ax),zeros(length(C1),1),'r*')
hold on, plot(C(C2,ax),zeros(length(C2),1),'b*')
hold on, plot(C(C3,ax),zeros(length(C3),1),'g*')
title('axe 2')

% C3 se decoupe en trois classes sur la deuxieme composante
C4 = find(C(:,2)<-15);C3 = setdiff(C3,C4);
C5 = find(C(:,2)>15); C3 = setdiff(C3,C5);
if(~all(sort([C1;C2;C3;C4;C5])==(1:nb_indiv)'))
    disp('something wrong happend')
end

figure(4), clf
subplot(2,1,1)
ax = 2;
plot([min(C(:,ax))-1 max(C(:,ax))+1],[0 0],'k-',C(C1,ax),zeros(length(C1),1),'r*')
hold on, plot(C(C2,ax),zeros(length(C2),1),'b*')
hold on, plot(C(C3,ax),zeros(length(C3),1),'g*')
hold on, plot(C(C4,ax),zeros(length(C4),1),'m*')
hold on, plot(C(C5,ax),zeros(length(C5),1),'k*')
title('axe 2')
subplot(2,1,2)
ax = 3;
plot([min(C(:,ax))-1 max(C(:,ax))+1],[0 0],'k-',C(C1,ax),zeros(length(C1),1),'r*')
hold on, plot(C(C2,ax),zeros(length(C2),1),'b*')
hold on, plot(C(C3,ax),zeros(length(C3),1),'g*')
hold on, plot(C(C4,ax),zeros(length(C4),1),'m*')
hold on, plot(C(C5,ax),zeros(length(C5),1),'k*')
title('axe 3')

% C1 se decoupe en 2 classes sur la troisieme composante principale
C6 = find(C(:,3)<-15);C1 = setdiff(C1,C6);
if(~all(sort([C1;C2;C3;C4;C5;C6])==(1:nb_indiv)'))
    disp('something wrong happend')
end

% On affiche la figure 10 : on ne peut plus decouvrir personne 
figure(10), clf
subplot(3,2,1)
ax = 1;
plot([min(C(:,ax))-1 max(C(:,ax))+1],[0 0],'k-',C(C1,ax),zeros(length(C1),1),'r*')
hold on, plot(C(C2,ax),zeros(length(C2),1),'b*')
hold on, plot(C(C3,ax),zeros(length(C3),1),'g*')
hold on, plot(C(C4,ax),zeros(length(C4),1),'k*')
hold on, plot(C(C5,ax),zeros(length(C5),1),'m*')
hold on, plot(C(C6,ax),zeros(length(C6),1),'y*')
title('axe 1')
subplot(3,2,2)
ax = 2;
plot([min(C(:,ax))-1 max(C(:,ax))+1],[0 0],'k-',C(C1,ax),zeros(length(C1),1),'r*')
hold on, plot(C(C2,ax),zeros(length(C2),1),'b*')
hold on, plot(C(C3,ax),zeros(length(C3),1),'g*')
hold on, plot(C(C4,ax),zeros(length(C4),1),'k*')
hold on, plot(C(C5,ax),zeros(length(C5),1),'m*')
hold on, plot(C(C6,ax),zeros(length(C6),1),'y*')
title('axe 2')
subplot(3,2,3)
ax = 3;
plot([min(C(:,ax))-1 max(C(:,ax))+1],[0 0],'k-',C(C1,ax),zeros(length(C1),1),'r*')
hold on, plot(C(C2,ax),zeros(length(C2),1),'b*')
hold on, plot(C(C3,ax),zeros(length(C3),1),'g*')
hold on, plot(C(C4,ax),zeros(length(C4),1),'k*')
hold on, plot(C(C5,ax),zeros(length(C5),1),'m*')
hold on, plot(C(C6,ax),zeros(length(C6),1),'y*')
title('axe 3')
subplot(3,2,4)
ax = 4;
plot([min(C(:,ax))-1 max(C(:,ax))+1],[0 0],'k-',C(C1,ax),zeros(length(C1),1),'r*')
hold on, plot(C(C2,ax),zeros(length(C2),1),'b*')
hold on, plot(C(C3,ax),zeros(length(C3),1),'g*')
hold on, plot(C(C4,ax),zeros(length(C4),1),'k*')
hold on, plot(C(C5,ax),zeros(length(C5),1),'m*')
hold on, plot(C(C6,ax),zeros(length(C6),1),'y*')
title('axe 4')
subplot(3,2,5)
ax = 5;
plot([min(C(:,ax))-1 max(C(:,ax))+1],[0 0],'k-',C(C1,ax),zeros(length(C1),1),'r*')
hold on, plot(C(C2,ax),zeros(length(C2),1),'b*')
hold on, plot(C(C3,ax),zeros(length(C3),1),'g*')
hold on, plot(C(C4,ax),zeros(length(C4),1),'k*')
hold on, plot(C(C5,ax),zeros(length(C5),1),'m*')
hold on, plot(C(C6,ax),zeros(length(C6),1),'y*')
title('axe 5')
subplot(3,2,6)
ax = 6;
plot([min(C(:,ax))-1 max(C(:,ax))+1],[0 0],'k-',C(C1,ax),zeros(length(C1),1),'r*')
hold on, plot(C(C2,ax),zeros(length(C2),1),'b*')
hold on, plot(C(C3,ax),zeros(length(C3),1),'g*')
hold on, plot(C(C4,ax),zeros(length(C4),1),'k*')
hold on, plot(C(C5,ax),zeros(length(C5),1),'m*')
hold on, plot(C(C6,ax),zeros(length(C6),1),'y*')
title('axe 6')


disp('Fin de l analyse de Y= transpose(X) : 6 classes trouvees')

% Peut-on decouper la classe C1 ?
X1 =X(C1,:);
[nb_indiv,~] = size(X1);
x_mean = mean(X1);
Xc = X1-ones(nb_indiv,1)*x_mean; 
S = 1/nb_indiv*(Xc'*Xc); [W,D] = eig(S); [D,tri]=sort(diag(D),'descend');
W = W(:,tri);
C = Xc*W;
figure(12), clf
ax = 1;
plot([min(C(:,ax))-1 max(C(:,ax))+1],[0 0],'k-',C(:,ax),zeros(nb_indiv,1),'r*')
title('axe 1')
disp('Fin de l analyse de Y(C1,:) :  pas de nouvelle coupe')

% Peut-on decouper C2 ?
X1 =X(C2,:);
[nb_indiv,~] = size(X1);
x_mean = mean(X1);
Xc = X1-ones(nb_indiv,1)*x_mean; 
S = 1/nb_indiv*(Xc'*Xc); [W,D] = eig(S); [D,tri]=sort(diag(D),'descend');
W = W(:,tri);
C = Xc*W;
figure(22), clf
ax = 1;
plot([min(C(:,ax))-1 max(C(:,ax))+1],[0 0],'k-',C(:,ax),zeros(nb_indiv,1),'r*')
title('axe 1')
disp('Fin de l analyse de Y(C2,:) :  pas de nouvelle coupe')

% Peut-on decouper C3 ?
X1 =X(C3,:);
[nb_indiv,~] = size(X1);
x_mean = mean(X1);
Xc = X1-ones(nb_indiv,1)*x_mean; 
S = 1/nb_indiv*(Xc'*Xc); [W,D] = eig(S); [D,tri]=sort(diag(D),'descend');
W = W(:,tri);
C = Xc*W;
figure(32), clf
ax = 1;
plot([min(C(:,ax))-1 max(C(:,ax))+1],[0 0],'k-',C(:,ax),zeros(nb_indiv,1),'r*')
title('axe 1')
disp('Fin de l analyse de Y(C3,:) :  pas de nouvelle coupe')

% Peut-on decouper C4 ?
X1 =X(C4,:);
[nb_indiv,~] = size(X1);
x_mean = mean(X1);
Xc = X1-ones(nb_indiv,1)*x_mean; 
S = 1/nb_indiv*(Xc'*Xc); [W,D] = eig(S); [D,tri]=sort(diag(D),'descend');
W = W(:,tri);
C = Xc*W;
figure(42), clf
ax = 1;
plot([min(C(:,ax))-1 max(C(:,ax))+1],[0 0],'k-',C(:,ax),zeros(nb_indiv,1),'r*')
title('axe 1')
disp('Fin de l analyse de Y(C4,:) :  pas de nouvelle coupe')

% Peut-on decouper C5 ?
X1 =X(C5,:);
[nb_indiv,~] = size(X1);
x_mean = mean(X1);
Xc = X1-ones(nb_indiv,1)*x_mean; 
S = 1/nb_indiv*(Xc'*Xc); [W,D] = eig(S); [D,tri]=sort(diag(D),'descend');
W = W(:,tri);
C = Xc*W;
figure(52), clf
ax = 1;
plot([min(C(:,ax))-1 max(C(:,ax))+1],[0 0],'k-',C(:,ax),zeros(nb_indiv,1),'r*')
title('axe 1')
disp('Fin de l analyse de Y(C5,:) :  pas de nouvelle coupe')

% Peut-on decouper C6 ?
X1 =X(C6,:);
[nb_indiv,~] = size(X1);
x_mean = mean(X1);
Xc = X1-ones(nb_indiv,1)*x_mean; 
S = 1/nb_indiv*(Xc'*Xc); [W,D] = eig(S); [D,tri]=sort(diag(D),'descend');
W = W(:,tri);
C = Xc*W;
figure(62), clf
ax = 1;
plot([min(C(:,ax))-1 max(C(:,ax))+1],[0 0],'k-',C(:,ax),zeros(nb_indiv,1),'r*')
title('axe 1')
disp('Fin de l analyse de Y(C6,:) :  pas de nouvelle coupe')