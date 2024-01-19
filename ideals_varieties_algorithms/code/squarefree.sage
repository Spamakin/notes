# Problem 5.15b of Chapter 1

# We want to compute the squarefree part of the following polynomial
# f = x^{11} - x^{10} + 2x^{8} - 4x^{7} + 3x^{5} - 3x^{4} + x^{3} + 3x^{2} - x - 1
R.<x> = PolynomialRing(CC)

f = x^11 - x^10 + 2 * x^8 - 4 * x^7 + 3 * x^5 - 3 * x^4 + x^3 + 3 * x^2 - x - 1
print(f"{f = }")

df = derivative(f, x)
print(f"{df = }")

g = f.gcd(df)
print(f"{g = }")

f_red = f / g
print(f"{f_red = }")
print(latex(f_red.factor()))
