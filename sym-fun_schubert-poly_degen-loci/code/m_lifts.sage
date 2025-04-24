import itertools

# following section 2.7.2 of Manivel

def find_lifts_qmax(n, w, m, p, qmax):
    # find m-left lifts of degree p of w with maximum q for zeta

    l = w.length()
    res = []
    zetas = []

    # enumerate all cycles of length p + 1 of desired form and check
    for q in range(m + 1, qmax + 1):
        for tup in itertools.permutations(range(1, m + 1), r = int(p)):
            z_elems = [q] + list(tup)
            # check w(q) > w(tup[0]) > ... > w(tup[p])
            if w(q) <= w(tup[0]):
                continue
            if any(w(tup[i]) <= w(tup[i + 1]) for i in range(p - 1)):
                continue

            # form cycle string
            z_elems_str = [str(elem) for elem in z_elems]
            z_str = "(" + ",".join(z_elems_str) + ")"
            zeta = Permutation(z_str)

            wz = zeta * w
            if wz.length() != l + p:
                continue

            res.append(wz)
            zetas.append(zeta)

    return res, zetas
    
def find_lifts(n, w, m, p):
    # find m-left lifts of degree p of w

    lifts = []
    zetas = []

    # I think max q we need to worry about is n?
    # But how to find suitable n given w, m, p?
    for q in range(1, n + 1):
        lifts_q, zetas_q = find_lifts_qmax(n, w, m, p, q)
        if len(lifts_q) > len(lifts):
            lifts = lifts_q
            zetas = zetas_q

    return lifts, zetas

def main():
    n = 6
    w_list = [1,2,3,5,4]
    w_list_n = w_list + [i for i in range(len(w_list) + 1, n + 1)]
    w = Permutation(w_list_n)
    print(w)
    print()
    m = 5
    p = 5
    lifts, zetas = find_lifts(n, w, m, p)
    # for lift, zeta in zip(lifts, zetas):
    #     print(lift)
    #     print(zeta)
    #     print()

    X = SchubertPolynomialRing(ZZ)
    Sw = X(w).expand()
    print(f"S_w = {Sw}")
    e = SymmetricFunctions(ZZ).e()
    ep = e([p]).expand(m)
    print(f"e_p = {ep}")
    lhs = Sw*ep
    print(f"S_w * e_p = {lhs}")
    print()
    rhs = 0
    for lift in lifts:
        print(f"{lift = }")
        print(X(lift).expand())
        print()
        rhs += X(lift).expand()
    print(lhs == rhs)
    print(lhs)
    print()
    print(rhs)

if __name__ == "__main__":
    main()
