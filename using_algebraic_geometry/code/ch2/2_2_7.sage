
# Implementation of UAG Exercise 1.3.11

def intersect(R, I, J):
    # return the intersection of ideals I, J

    # compute Groebner bases for I, J
    GI = I.groebner_basis()
    GJ = J.groebner_basis()

    # form new ring with t > all other vars
    new_vars = []
    for gen in R.gens():
        new_vars.append(str(gen))
    new_vars = ["t"] + new_vars
    S = PolynomialRing(R.base_ring(), new_vars, order='lex')
    S.inject_variables()

    # form bases for tI, (1 - t)J
    I_ = S.ideal([t*gen for gen in GI])
    J_ = S.ideal([(1 - t)*gen for gen in GJ])

    # compute Groebner basis H for tI + (1 - t)J
    comb = I_ + J_
    comb_basis = comb.groebner_basis()

    # compute H intersect R
    H_R = []
    for gen in comb_basis:
        if t not in gen.variables():
            H_R.append(R(gen))

    return R.ideal(H_R)

def main():
    R.<x, y> = PolynomialRing(CC, 2, order='degrevlex')
    I1 = R.ideal(x, y)
    I2 = R.ideal(x - 1, y - 1)
    I3 = R.ideal(x + 1, y - 1)
    I4 = R.ideal(x - 1, y + 1)
    I5 = R.ideal(x - 2, y + 1)

    res = I1
    res = intersect(R, res, I2)
    res = intersect(R, res, I3)
    res = intersect(R, res, I4)
    res = intersect(R, res, I5)

    print(res.groebner_basis())


if __name__ == "__main__":
    main()
