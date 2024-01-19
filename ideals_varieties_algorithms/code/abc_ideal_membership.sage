# Problem 8.11 of Chapter 2

from sage.rings.polynomial.toy_buchberger import buchberger

R.<a, b, c> = PolynomialRing(QQ, order='lex')

I = R.ideal([a + b + c - 3,
             a^2 + b^2 + c^2 - 5,
             a^3 + b^3 + c^3 - 7,
             ])

# part a
print(f"{a^4 + b^4 + c^4 - 9 in I}") # true

# part b
print(f"{a^5 + b^5 + c^5 - 11 in I}") # false

# part c
print(f"a^5 + b^5 + c^5 = {I.reduce(a^5 + b^5 + c^5)}") # 29/3
print(f"a^6 + b^6 + c^6 = {I.reduce(a^6 + b^6 + c^6)}") # 19/3
