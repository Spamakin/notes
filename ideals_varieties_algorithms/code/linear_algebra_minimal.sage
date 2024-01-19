# Problem 7.9 of Chapter 2

# We want to compute Goebner bases of the following ideals.
from sage.rings.polynomial.toy_buchberger import LCM, LT


R.<x, y, z, w> = PolynomialRing(QQ, order='lex')

def S(f, g):
    lcm = LCM(f, g)
    lt_f = LT(f)
    lt_g = LT(g)

    return (lcm / lt_f * f) - (lcm / lt_g * g)

I = R.ideal([3*x - 6*y - 2*z, 2*x - 4*y + 4*w, x - 2*y - z - w])

f = x - 2*y - z - w
g = z + 3*w

# print(latex(f))
# print(latex(g))
print(latex(S(f, g)))
