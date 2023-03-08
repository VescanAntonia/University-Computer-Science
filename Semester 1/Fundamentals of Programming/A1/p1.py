# Solve the problem from the first set here
#Given natural number `n`, determine the prime numbers `p1` and `p2` such that `n = p1 + p2` (check the Goldbach hypothesis).

def check_prime(x):
    """
    :param x: the number which needs to be checked
    :return: checks whether or not x is prime
    """
    for i in range (2,x-1):
      if x%i==0:
         return 0
      else: return 1


def start():
   """
   :return: find 2 prime numbers that have the sum n
   """
   n=int(input("Enter n="))
   for j in range (2,n-1):
        for k in range (2,n-1):
            if check_prime(j)==check_prime(k) and check_prime(k)==1 and j<=k and j+k==n:
                print(j,k)


start()
