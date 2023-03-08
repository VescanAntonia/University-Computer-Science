# Solve the problem from the third set here
#Determine the `n-th`  element of the sequence `1,2,3,2,5,2,3,7,2,3,2,5,...` obtained from the sequence of natural numbers by replacing composed numbers with their prime divisors, without memorizing the elements of the sequence.


def find_el(n):
    """
    :param n: the position of the element we are looking for
    :return: the n-th element of the sequence
    """
    p=1
    q=2
    while p<n:
        d=2
        y=q
        while y>1:
            if y%d==0:
                p=p+1
            while y%d==0:
             y=y/d
            if p!=n:
                d=d+1
            else:
             return d
            q=q+1
    return 1

def start():
 n = int(input("Enter n:"))
 print(str(find_el(n)))


start()