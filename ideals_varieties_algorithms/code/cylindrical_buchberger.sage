# Problem 8.8 of Chapter 2

from sage.rings.polynomial.toy_buchberger import buchberger

print("order = lex")
R.<a, b, c, d, x, y, z> = PolynomialRing(QQ, order='lex')

I = R.ideal([x - (2 + a)*c,
             y - (2 + a)*d,
             z - b,
             a^2 + b^2 - 1,
             c^2 + d^2 - 1,
             ])
gb = buchberger(I)
print(latex(gb))
