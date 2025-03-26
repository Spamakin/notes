from collections import deque

def find_maximal_transitions(w):
    r = max(w.descents())
    n = w.size()
    s = max(i for i in range(r + 1, n + 1) if w(i) < w(r))
    res = []
    for j in range(1, r):
        if w(j) < w(s):
            if all(not(w(j) < w(i) < w(s)) for i in range(j + 1, r)):
                res.append(j)
    return res

def LS_tree_children(w):
    n = w.size()
    r = max(w.descents())
    s = max(i for i in range(r + 1, n + 1) if w(i) < w(r))
    transitions = find_maximal_transitions(w)
    res = []
    for j in transitions:
        tjr = Permutation(f"({j}, {r})")
        trs = Permutation(f"({r}, {s})")
        v = tjr * trs * w
        res.append(v)
    return res

def LR_tree_leaves(w):
    n = w.size()
    res = []
    check = deque([w])
    while len(check) > 0:
        curr = check.popleft()
        print(f"Checking {curr}")
        if not(curr.has_pattern([2,1,4,3])):
            print(f"    adding leaf {curr}")
            res.append(curr)
        else:
            children = LS_tree_children(curr)
            if len(children) > 0:
                for child in children:
                    print(f"    appending {child}")
                    check.append(child)
            else:
                print("    no children")
                one_x_curr = [1] + [i + 1 for i in list(curr)]
                check.append(Permutation(one_x_curr))
                print(f"    appending {Permutation(one_x_curr)}")
    return res

def main():
    # leaves = LR_tree_leaves(Permutation([2,4,1,3,6,8,5,7]))
    # print()
    # for leaf in leaves:
    #     print(leaf)
    #     shape = list(reversed(sorted(leaf.to_lehmer_code())))
    #     print(shape)
    #     print()

    w = Permutation([1,4,2,3,6,5])
    print(find_maximal_transitions(w))

if __name__ == "__main__":
    main()
