clear variables;clc
% tolerance relative pour l ecart entre deux iteration successives de la
% suite tendant vers le vecteur propre dominant
eps = 1e-8;
kmax = 5000; % nombre d iterations max pour atteindre la convergence (si i > kmax, l'algo finit)

% Generation d une matrice rectangulaire aleatoire A de taille nxp.
% On cherche le vecteur propre et la valeur propre dominants de AA^T puis
% de A^TA
n = 2500; p = 500;
A = 5*randn(n,p);
% AAt, AtA : equations normales de la matrice A
AAt = A*A'; AtA = A'*A;
normAAt = norm(AAt);
normAtA = norm(AtA);
%% Methode de la puissance iteree pour la matrice AAt de taille nxn
% Point de depart de l'algorithme de la puissance iteree : un vecteur
% aleatoire, normalise
x = ones(n,1); x = x/norm(x);

non_cv= true;
iv1 = 0;  % pour compter le nombre d iterations effectuees
t_v1 =  cputime; % pour calculer le temps d execution de l'algo

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% CODER L ALGORITHME DE LA PUISSANCE ITEREE TEL QUE DONNE DANS L'ENONCE
% POUR LA MATRICE AAt
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
while(non_cv)
    x = AAt*x;
    x = x/norm(x);
    lambda = x'*AAt*x;
    err1 = norm(x*lambda - AAt*x)/normAAt;
    if(err1<eps || iv1>kmax)
        non_cv = false;
    end
    iv1 = iv1+1;
end
t_v1 = cputime-t_v1; % t_version1 : temps d execution de l algo
% de la puissance iteree pour la matrice AAt

%% Methode de la puissance iteree pour la matrice AtA de taille pxp
% Point de depart de l'algorithme de la puissance iteree : un vecteur
% aleatoire, normalise
y = ones(p,1); y = y/norm(y);

non_cv = true;
iv2 = 0;  % pour compter le nombre d iterations effectuees
t_v2 =  cputime; % pour calculer le temps d execution de l'algo
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% CODER L ALGORITHME DE LA PUISSANCE ITEREE TEL QUE DONNE DANS L'ENONCE
% POUR LA MATRICE AtA
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
while(non_cv)
    y = AtA*y;
    y = y/norm(y);
    nu = y'*AtA*y;
    err2 = norm(y*nu - AtA*y)/normAtA;
    if(err2<eps || iv2>kmax)
        non_cv = false;
    end
    iv2 = iv2+1;
    
end
t_v2 = cputime-t_v2;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% APRES VOUS ETRE ASSURE DE LA CONVERGENCE DES DEUX METHODES, AFFICHER 
% L'ECART RELATIF ENTRE LES DEUX VALEURS PROPRES TROUVEES, ET LE TEMPS
% MOYEN PAR ITERATION POUR CHACUNE DES DEUX METHODES. 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
fprintf('Erreur relative pour la methode avec la grande matrice = %0.3e\n',err1);
fprintf('Erreur relative pour la methode avec la petite matrice = %0.3e\n',err2);
fprintf('Ecart relatif entre les deux valeurs propres trouvees = %1.2e\n', abs(lambda-nu)/abs(nu))
fprintf('Temps pour une ite avec la grande matrice = %0.3e\n',t_v1/iv1);
fprintf('Temps pour une ite avec la petite matrice = %0.3e\n',t_v2/iv2);
