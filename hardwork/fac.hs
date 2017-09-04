fac 0 = 1
fac n = if n < 2 
        then n * fac(n - 1)
        else n * (n - 1) * fac(n - 2)
main = print (fac 4)