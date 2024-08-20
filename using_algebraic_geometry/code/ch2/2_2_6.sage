
def main():
    R.<x, y> = PolynomialRing(QQ, 2, order="degrevlex")
    I = R.ideal(y^4*x + 3*x^3 - y^4 - 3*x^2, x^2*y - 2*x^2, 2*y^4*x - x^3 - 2*y^4 + x^2)
    print(f"Groebner Basis for I = {I.groebner_basis()}")
    basis = I.normal_basis()
    d = len(basis)
    for i in range(d):
        for j in range(i + 1, d):
            print(f"{str(basis[i]):<5} * {str(basis[j]):<5} = {(basis[i]*basis[j]).reduce(I)}")

if __name__ == "__main__":
    main()
