# Solve the problem from the second set here
#Consider a given natural number `n`. Determine the product `p` of all the proper factors of `n`.

def start():
    """
    :return: the product of all the proper factors of n
    """
    n=int(input("Enter n="))
    p=1
    for i in range (2,n-1):
        if n%i==0: p=p*i
    print(p)
start()
