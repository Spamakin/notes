
# from 2_2_2.sage
def single_var_generator(R, I, x):
    if I.dimension() != 0:
        raise ValueError(f"The inputted ideal I is not zero dimensional: dim(I) = {I.dimension()}")

    # ordering of standard monomials + other info
    NB = I.normal_basis()
    gens = R.gens()
    G = I.groebner_basis()

    # get upper bound on degree of x in Groebner basis for I
    min_deg_x = oo
    for g in G:
        if g.lt().nvariables() == 1 and g.lt().degree(x) > 0:
            min_deg_x = min(min_deg_x, g.lt().degree(x))
    min_deg_x -= 1 # largest m such that x^m in NB

    # form matrix, len(NB) x (min_deg_x + 2)
    M = matrix(R.base_ring(), len(NB), 0)
    j = 0
    while True:
        # column j = coeffs of reduced form of x^j wrt I, ordered by NB
        red = (x^j).reduce(G)
        new_col = vector(R.base_ring(), [1 for _ in range(len(NB))])
        for i, m in enumerate(NB):
            new_col[i] = red.monomial_coefficient(m)
        M = M.augment(new_col)
        if len(M.right_kernel().basis()) > 0:
            res = 0
            for i, coeff in enumerate(M.right_kernel().basis()[0]):
                res += coeff * x^i
            return res
        j += 1

def main():
    R.<x, y> = PolynomialRing(QQ, 2)
    I = R.ideal(x^2 + 3*x*y/2 + y^2/2 - 3*x/2 - 3*y/2, x*y^2 - x, y^3 - y)
    p_x = single_var_generator(R, I, x)
    p_x_red = p_x / (p_x.gcd(derivative(p_x, x)))
    p_y = single_var_generator(R, I, y)
    p_y_red = p_y / (p_y.gcd(derivative(p_y, y)))

    print(f"{p_x     = }")
    print(f"{p_x_red = }")
    print(f"{p_y     = }")
    print(f"{p_y_red = }")

    constructed_rad = I + R.ideal(p_x_red) + R.ideal(p_y_red)
    print(f"I == sqrt(I) == I + <p_x_rad, p_y_rad>: {I == constructed_rad == I.radical()}")


if __name__ == "__main__":
    main()
