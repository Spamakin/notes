def bigrassmannian(n):
    perms = Permutations(n)
    buckets = [[] for _ in range(n)]
    for p in perms:
        if 1 == len(p.descents()) == len(p.idescents()):
            dec = p.descents()[0]
            buckets[dec].append(p)

    for dec in range(n - 1):
        if len(buckets[dec]) == 0:
            continue
        print(f"dec = {dec}")
        print(f"{dec} x {n - dec}")
        for p in buckets[dec]:
            print(p)
            print(p.to_lehmer_code())
            p.rothe_diagram().pp()
            print()

def grassmannian(n):
    for dec in range(n - 1):
        print(f"dec = {dec + 1}")
        print(f"{dec + 1} x {n - (dec + 1)}")
        perms = Permutations(descents=([dec], n))
        for p in perms:
            print(p)
            print(p.to_lehmer_code())
            p.rothe_diagram().pp()
            print()

def main():
    n = 6
    bigrassmannian(n)

if __name__ == "__main__":
    main()
