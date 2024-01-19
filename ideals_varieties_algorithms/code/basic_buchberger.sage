# Problem 7.2 of Chapter 2

# We want to compute Goebner bases of the following ideals.
from sage.rings.polynomial.toy_buchberger import buchberger

print("Part a.")

print("order = lex")
R.<x, y> = PolynomialRing(QQ, order='lex')

I = R.ideal([x^2 * y - 1, x * y^2 - x])
gb = buchberger(I)
print(latex(gb))

print("order = grlex")
R.<x, y> = PolynomialRing(QQ, order='deglex')

I = R.ideal([x^2 * y - 1, x * y^2 - x])
gb = buchberger(I)
print(latex(gb))

####################################################

print("Part b.")

print("order = lex")
R.<x, y> = PolynomialRing(QQ, order='lex')

I = R.ideal([x^2 + y, x^4 + 2 * x^2 * y + y^2 + 3])
gb = buchberger(I)
print(latex(gb))

print("order = grlex")
R.<x, y> = PolynomialRing(QQ, order='deglex')

I = R.ideal([x^2 + y, x^4 + 2 * x^2 * y + y^2 + 3])
gb = buchberger(I)
print(latex(gb))

####################################################

print("Part c.")

print("order = lex")
R.<x, y, z> = PolynomialRing(QQ, order='lex')

I = R.ideal([x - z^4, y - z^5])
gb = buchberger(I)
print(latex(gb))

print("order = grlex")
R.<x, y, z> = PolynomialRing(QQ, order='deglex')

I = R.ideal([x - z^4, y - z^5])
gb = buchberger(I)
print(latex(gb))
