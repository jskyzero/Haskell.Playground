{-

  理解无穷列表,基理:惰性计算

  take drop length 包含类型变量,多态函数.

  证明:a^2 + b^2 / ab + 1 is a square number
  
-} 


{-

    Library System

    type DataBase = (String, String)

    使用列表概括

-}

-- 无穷列表
fib = 1:1:[x + y | (x, y) <- zip fib (tail fib)]

-- 返回因子
factors n = [x | x <- [1..n], mod n x == 0]
-- 判断素数
isPrime n = length( factors n ) == 2

-- name, number, each price
type Item  = (String, Float, Float)
type Items = [Item]

-- total price
total :: Items -> Float
total [] = 0
total ((name, amount, price):xs) = amount * price +  (total xs)
-- total xs = [ price | (name, amout, price) <- xs] 
-- can't use to sum

example :: Items
example = [("Apple", 2.3, 5.8),
           ("Bread", 1, 4.5)]

{-
  About IO
  IO String is a type

  Use Show to change num to String
-}

-- print item to screen
printItem :: Item -> String
printItem (n, a, p) = n ++ show a ++ show p ++ show (a * p) ++ "\n"

-- print Items to screen
printItems :: Items -> String
printItems [] = ""
printItems (x:xs) = printItem x ++ printItems xs

printAll :: Items -> IO()
printAll xs = putStrLn((printItems xs) ++ show(total xs))
-- putStrLn(show [1..100])

{-
总结:
  分解问题,先对单个入手,然后递归.自上而下的思想.
-}