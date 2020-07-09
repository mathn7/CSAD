% On verifie que dans la table de donnees X de dataset, on a bien les
% valeurs propres des deux matrices de variance/covariance à peu pres 
% égales à une multiplication par une constante pret 
load('dataset')
[n1,n2] =size(X);
Xc = X-mean(X);
S = 1/n1*Xc'*Xc;
[W,D] = eig(S);
[D1,tri] = sort(diag(D),'descend');
W1 = W(:,tri);

Y = X';
Yc = Y-mean(Y);
S = 1/n2*Yc'*Yc;
[W,D] = eig(S);
[D2,tri] = sort(diag(D),'descend');
W2 = W(:,tri);

n = min(n1,n2);

ecart_vp = (abs(n1*D1(1:n)-n2*D2(1:n)));
erreur = max(ecart_vp);




