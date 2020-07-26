"""
Projection de Rayleigh-Ritz

# Données
    - A : matrice dont on cherche des couples propres
    - V : ensemble de m vecteurs orthonormés

# Résultats
    - W : vecteur contenant les approximations des valeurs propres
    - V : matrice des vecteurs propres correspondant
"""
function rayleigh_ritz_projection(A, V)

    H = V'*(A*V)
    DH, VH = eigen(H)
    indice = sort(DH, rev=true)
    W = W[indice]
    V = V*VH[:, indice]

    return W, V
end
