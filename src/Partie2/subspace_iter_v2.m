% version améliorée de la méthode de l'espace invariant (v2)
% avec utilisation de la projection de Raleigh-Ritz 
% + une approche par bloc
% + de la déflation 

% Données
% A          : matrice dont on cherche des couples propres
% m          : taille maximale de l'espace invariant que l'on va utiliser
% percentage : pourcentage de la trace recherché
% p          : nombre de produits Y = A^p . V
% eps        : seuil pour déterminer si un vecteur de l'espace invariant a convergé
% maxit      : nombre maximum d'itération de la méthode

% Résultats
% W : vecteur contenant les valeurs propres (ordre décroissant)
% V : matrice des vecteurs propres correspondant
% n_ev : nombre de valeurs propres calculées
% it   : nombre d'itérations de la méthode
% flag : indicateur sur la terminaison de l'algorithme
    %  flag = 0  : on converge en ayant atteint le pourcentage de la trace recherché
    %  flag = 1  : on converge en ayant atteint la taille maximale de l'espace
    %  flag = -3 : on n'a pas convergé en maxit itérations

function [ W, V, n_ev, it, flag ] = subspace_iter_v2( A, m, percentage, p, eps, maxit )

    % calcul de la norme de A (pour le critère de convergence d'un vecteur (gamma)
    normA = norm(A, 'fro');

    % trace de A
    traceA = trace(A);

    % valeur correspondnat au pourcentage de la trace à atteindre
    vtrace = percentage*traceA;

    n = size(A,1);
    W = zeros(n,1);

    % numéro de l'itération courante
    k = 0;
    % somme courante des valeurs propres
    eigsum = 0.0;
    % nombre de vecteurs ayant convergés
    nb_c = 0;

    % indicateur de la convergence
    conv = 0;

    % on génère un ensemble initial de m vecteurs orthogonaux
    Vr = randn(n, m);
    Vr = mgs(Vr);
    
    % rappel : conv = (eigsum >= p_trace) | (nb_c == m)
    while (~conv & k < maxit/p),
        
        k = k+1;
        
        % Vr = [Vc Vnc]
        % Vc = Vr(:, 1:nb_c)
        % Vnc = Vr(:, nb_c+1:m)
        
        %% Y <- (A^p)*Vnc
        for j = 1:p
            Y = A*Vr(:, nb_c+1:m);
            Vr(:, nb_c+1:m) = Y;
        end
        
        %% orthogonalisation des m-nb_c derniers vecteurs de Vr
        Vr = mgs_block(Vr, nb_c);
        %Vr = mgs(Vr);
        
        %% Projection de Rayleigh-Ritz pour les vecteurs n'ayant pas convergés
        [Wr, Y] = rayleigh_ritz_projection(A, Vr(:, nb_c+1:m));
        
        % on range les nouveaux vecteurs après ceux qui ont déjà convergés
        Vr(:,nb_c+1:m) = Y;
        
        %% Quels vecteurs ont convergé à cette itération
        analyse_cvg_finie = 0;
        % nombre de vecteurs ayant convergé à cette itération
        nbc_k = 0;
        % nb_c est le dernier vecteur à avoir convergé à l'itération précédente
        i = nb_c + 1;
        
        while(~analyse_cvg_finie),
            % tous les vecteurs de notre sous-espace ont convergé
            % on a fini (sans avoir obtenu le pourcentage)
            if(i > m)
                analyse_cvg_finie = 1;
            else
                % est-ce que le vecteur i a convergé
                
                % calcul de la norme du résidu
                % attention au décalage dans le vecteur des valeurs propres
                % en sortie de la projection
                aux = A*Vr(:,i) - Wr(i-nb_c)*Vr(:,i);
                res = sqrt(aux'*aux);
                
                if(res >= eps*normA)
                    % le vecteur i n'a pas convergé,
                    % on sait que les vecteurs suivants n'auront pas convergé non plus
                    % => itération finie
                    analyse_cvg_finie = 1;
                else
                    % le_vecteur i a convergé
                    % un de plus
                    nbc_k = nbc_k + 1;
                    % on stocke sa valeur propre au bon endroit dans le
                    % résultat W
                    W(i) = Wr(i-nb_c);
                    
                    % on met à jour la somme des valeurs propres
                    eigsum = eigsum + W(i);
                    
                    % si cette valeur propre permet d'atteindre le pourcentage
                    % on a fini
                    if(eigsum >= vtrace)
                        analyse_cvg_finie = 1;
                    else
                        % on passe au vecteur suivant
                        i = i + 1;
                    end
                end
            end
        end
        
        % on met à jour le nombre de vecteurs ayant convergés
        nb_c = nb_c + nbc_k;
        
        % on a convergé dans l'un de ces deux cas
        conv = (nb_c == m) | (eigsum >= vtrace);
        
    end
    
    if(conv)
        % mise à jour des résultats        
        n_ev = nb_c;
        W = W(1:n_ev);
        V = Vr(:, 1:n_ev);
        it = k;
    else
        % on n'a pas convergé
        W = zeros(1,1);
        V = zeros(1,1);
        n_ev = 0;
        it = k;
    end

    % on indique comment on a fini
    if(eigsum >= vtrace)
        flag = 0;
    else if (n_ev == m)
            flag = 1;
        else
            flag = -3;
        end
    end
end
