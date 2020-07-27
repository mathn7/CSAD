using LinearAlgebra
using Printf

# tolerance relative pour l ecart entre deux iteration successives de la
# suite tendant vers le vecteur propre dominant
eps = 1e-8
kmax = 5000 # nombre d iterations max pour atteindre la convergence (si i > kmax, l'algo finit)

# Generation d une matrice rectangulaire aleatoire A de taille nxp.
# On cherche le vecteur propre et la valeur propre dominants de AA^T puis
# de A^TA
n = 2500 
p = 500
A = 5*randn(n,p)
# AAt, AtA : equations normales de la matrice A
AAt = A * A' 
AtA = A' * A
# Methode de la puissance iteree pour la matrice AAt de taille nxn
# Point de depart de l'algorithme de la puissance iteree : un vecteur
# aleatoire, normalise
x = ones(n) 
x = x / norm(x)

non_cv = true
iv1 = 0  # pour compter le nombre d iterations effectuees

#println("** A COMPLETER ** CONSIGNES EN COMMENTAIRE **")

# CODER L ALGORITHME DE LA PUISSANCE ITEREE TEL QUE DONNE DANS L'ENONCE
# POUR LA MATRICE AAt

@time while non_cv 
    global x = AAt * x
    x = x / norm(x)
    global lambda = x' * AAt * x
    global err1 = norm(lambda * x - AAt * x) / abs(lambda)
    if(err1 < eps || iv1 > kmax)
        global non_cv = false
        println("\nTemps pour une ite avec la grande matrice:")
        printstyled("------------------------------------------\n> ",color=:green)
    end
    global iv1 = iv1 + 1
end
println("")

# de la puissance iteree pour la matrice AAt

# Methode de la puissance iteree pour la matrice AtA de taille pxp
# Point de depart de l'algorithme de la puissance iteree : un vecteur
# aleatoire, normalise
y = ones(p) 
y = y / norm(y)

non_cv = true
iv2 = 0  # pour compter le nombre d iterations effectuees

#println("** A COMPLETER ** CONSIGNES EN COMMENTAIRE **")

# CODER L ALGORITHME DE LA PUISSANCE ITEREE TEL QUE DONNE DANS L'ENONCE
# POUR LA MATRICE AtA

@time while non_cv
    global y = AtA * y
    y = y / norm(y)
    global nu = y' * AtA * y
    global err2 = norm(nu * y - AtA * y) / abs(nu)
    if(err2 < eps || iv2 > kmax)
        global non_cv = false
        println("Temps pour une ite avec la petite matrice:")
        printstyled("------------------------------------------\n>",color=:green)
    end
    global iv2 = iv2 + 1
end
println("")

#println("** A COMPLETER ** CONSIGNES EN COMMENTAIRE **")

# APRES VOUS ETRE ASSURE DE LA CONVERGENCE DES DEUX METHODES, AFFICHER 
# L'ECART RELATIF ENTRE LES DEUX VALEURS PROPRES TROUVEES, ET LE TEMPS
# MOYEN PAR ITERATION POUR CHACUNE DES DEUX METHODES. 

@printf("Erreur relative pour la methode avec la grande matrice = %0.3e\n",err1)
@printf("Erreur relative pour la methode avec la petite matrice = %0.3e\n",err2)
@printf("Ecart relatif entre les deux valeurs propres trouvees = %1.2e\n", abs(lambda-nu) / abs(nu))