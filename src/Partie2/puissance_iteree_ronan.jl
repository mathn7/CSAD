using Printf
using LinearAlgebra
# tolerance relative pour l ecart entre deux iteration successives de la
# suite tendant vers le vecteur propre dominant
eps = 1e-8
kmax = 5000 # nombre d iterations max pour atteindre la convergence (si i > kmax, l'algo finit)

# Generation d une matrice rectangulaire aleatoire A de taille nxp.
# On cherche le vecteur propre et la valeur propre dominants de AA^T puis
# de A^TA
n = 100 
p = 50
A = 5*randn(n,p)
# AAt, AtA : equations normales de la matrice A
AAt = A*A' 
AtA = A'*A
# Methode de la puissance iteree pour la matrice AAt de taille nxn
# Point de depart de l'algorithme de la puissance iteree : un vecteur
# aleatoire, normalise
x = ones(n) 
x = x/norm(x)

bool = true
iv1 = 0  # pour compter le nombre d iterations effectuees
#t_v1 =  cputime # pour calculer le temps d execution de l'algo

#println("** A COMPLETER ** CONSIGNES EN COMMENTAIRE **")

# CODER L ALGORITHME DE LA PUISSANCE ITEREE TEL QUE DONNE DANS LE
# SUJET, POUR LA MATRICE AAt

for i = 1:3
    @time while bool
        global x = AAt*x
        x = x / norm(x)
        global lambda = x'*AAt*x
        global err1 = norm(lambda*x - AAt*x)/abs(lambda)
        if err1<eps || iv1>kmax
            bool = false
            println("\nTemps pour une ite:"*string(i))
            printstyled("------------------------------------------\n> ",color=:green)
        end
        global iv1 = iv1+1
    end
    #t_v1 = cputime-t_v1 # t_version1 : temps d execution de l algo
    # de la puissance iteree pour la matrice AAt
    println(x)
    println(lambda)
    AAt = AAt - lambda*x*x'
end
# Methode de la puissance iteree pour la matrice AtA de taille pxp
# Point de depart de l'algorithme de la puissance iteree : un vecteur
# aleatoire, normalise

D,_ = eigen(AtA)
println(D)

vp1 =[]
y1 = []
#t_v2 =  cputime # pour calculer le temps d execution de l'algo

#println("** A COMPLETER ** CONSIGNES EN COMMENTAIRE **")

# CODER L ALGORITHME DE LA PUISSANCE ITEREE TEL QUE DONNE DANS LE
# SUJET, POUR LA MATRICE AtA
for i = 1:5
    y = ones(p,1) 
    y = y/norm(y)
    bool = true
    iv2 = 0  # pour compter le nombre d iterations effectuees
    @time while bool
        y = AtA*y
        y = y/norm(y)
        nu = y'*AtA*y
        err2 = norm(nu*y - AtA*y)/abs(nu)
        if err2<eps || iv2>kmax
            bool = false
        end
        iv2 = iv2+1
        
    end
    #t_v2 = cputime-t_v2
    y1 = [y1 y]
    vp1 = [vp1 nu]
    AtA = AtA - nu*y*y'
end
## t_v3 =  cputime # pour calculer le temps d execution de l'algo

display(vp1)
display(y1)
## t_v3 = cputime-t_v3

#println("** A COMPLETER ** CONSIGNES EN COMMENTAIRE **")

# APRES VOUS ETRE ASSURE DE LA CONVERGENCE DES DEUX METHODES, AFFICHER 
# L'ECART RELATIF ENTRE LES DEUX VALEURS PROPRES TROUVEES, ET LE TEMPS
# MOYEN PAR ITERATION POUR CHACUNE DES DEUX METHODES. CONCLURE SUR
# L'EFFICACITE
# @printf("Erreur relative pour la methode avec la grande matrice = %0.3e\n",err1)
# @printf("Erreur relative pour la methode avec la petite matrice = %0.3e\n",err2)
# @printf("Ecart relatif entre les deux valeurs propres trouvees = %1.2e\n", abs(lambda-nu)/abs(nu))
# @printf("Temps pour une ite avec la grande matrice = %0.3e\n",t_v1/iv1)
# @printf("Temps pour une ite avec la petite matrice = %0.3e\n",t_v2/iv2)

c = zeros(p,p)
vp2 = []
y2 = []

for i = 1:5   
    y = ones(p,1) 
    y = y/norm(y)    
    z = A*y
    z1 = c*y
    beta_p_1 = z'*z - z1'*z1
    bool = true
    iv2 = 0

    while bool
        z = A*y
        z1 = c*y
        y = A'*z - c'*z1
        y = y/norm(y)
        z = A*y
        z1 = c*y
        beta_p = z'*z - z1'*z1
        err2 = norm(beta_p - beta_p_1)/norm(beta_p_1)
        if(err2<eps || iv2>kmax)
            bool = false
        end
        iv2 = iv2+1
        beta_p_1 = beta_p
    end

    y2 = [y2 y]
    vp2 = [vp2 ;beta_p_1]

    c[i,:] = sqrt(beta_p_1)* y'

end

display(vp2)
display(y2)