
def main():
    R.<x, y> = PolynomialRing(QQ, 2, order="lex")
    I = R.ideal(y^4*x + 3*x^3 - y^4 - 3*x^2, x^2*y - 2*x^2, 2*y^4*x - x^3 - 2*y^4 + x^2)
    rad_I = I + R.ideal(x*(x - 1), y*(y - 2))

    print(f"dim(C[x, y] / I) = {len(I.normal_basis())}")
    print(f"dim(C[x, y] / sqrt(I)) = {len(rad_I.normal_basis())}")

if __name__ == "__main__":
    main()
