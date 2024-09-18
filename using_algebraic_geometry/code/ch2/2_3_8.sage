
def get_coeffs(R, I, f):
    B = I.normal_basis()
    coeffs = []
    g = I.reduce(f)
    for b in B:
        coeffs.append(g.coefficient(b))
        g -= coeffs[-1] * b
    return coeffs

def get_matrix(R, I, f, B_lex):
    B = I.normal_basis()
    F = R.base_ring()
    L = []
    for b in B_lex:
        L.append(vector(F, get_coeffs(R, I, b)))
    M = matrix(L).transpose()
    return M


def FLGM(R, R_lex, G):
    R.inject_variables(verbose=False)
    gens = R.gens()
    n = len(gens)
    x1 = max(var for var in gens)
    I = R.ideal(G)
    B = I.normal_basis()
    F = R.base_ring()

    G_lex = []
    B_lex = []

    curr = R(1)
    while True:
        # print(f"{G_lex = }")
        # print(f"{B_lex = }")
        # print(f"{curr = }")
        # print()

        # Main Loop
        curr_bar = I.reduce(curr)
        coeffs = get_coeffs(R, I, curr_bar)
        coeffs_v = vector(F, coeffs)
        M = get_matrix(R, I, curr, B_lex)
        # if lin dep
        if coeffs_v in M.column_space():
            c = M.solve_right(coeffs_v)
            g = curr
            for c, b in zip(c, B_lex):
                g -= c*b
            G_lex.append(R_lex(g))
            # Termination Test
            lt = G_lex[-1].lt()
            if lt.nvariables() == 1 and lt.variables()[0] == x1:
                B_lex = [R_lex(b) for b in B_lex]
                return G_lex, B_lex
        # if lin indep
        else:
            B_lex.append(curr)

        # Next Monomial
        k = 0
        next_mon = R(1)
        a = curr.degrees()
        for j in range(n):
            test_mon = R(1)
            for i in range(j + 1):
                test_mon *= gens[i]^a[i]
            test_mon *= gens[j]
            if all(R.monomial_divides(g.lt(), test_mon) == False for g in G_lex):
                k = j
                next_mon = test_mon
        curr = next_mon

def main():
    R.<z, y, x> = PolynomialRing(QQ, 3)
    R_lex.<z, y, x> = PolynomialRing(QQ, 3, order='lex')
    I = R.ideal(x*y + z - x*z, x^2 - z, 2*x^3 - x^2*y*z - 1)
    G = I.groebner_basis()
    G_lex, B_lex = FLGM(R, R_lex, G)
    print(f"{G_lex = }")
    print(f"{B_lex = }")
    print(Ideal(G_lex).basis_is_groebner())

if __name__ == "__main__":
    main()
