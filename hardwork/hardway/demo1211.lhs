状态不佳，最开始没有听讲

import System.Random

:i RandomGen

:t random
random :: (RandomGen g, random g) => g -> (a, g)

:t randomR
randomR :: (RandomGen g, Random a) => (a, a) -> g -> (a, g)

random (mkStdGen 1)



compile program, use ghc

> main :: IO ()
> main = do
>  putStrLn ("Hello World!")

lazy evaluation（sicp 正则序
能少算就少算
需要的时候才会去求=先展开化简
where引入的局部能计算一次就计算一次
计算次序，
从上到下 switch
从外至内
从左至右

带来的优点：
使用无穷的数据结构（放心使用代价大的值）
方便模块化，使用惰性计算将模块间粘合在一起。

1.非布拉奇数列

> fibs :: [Integer]
> fibs = 1:1: [x+y| (x, y) <- zip fibs (tail fibs)]

fibs !! 2

2.素数 筛选法

[2, 3, 4, 5, 6, ...]
[2] [3, 5, 7, ...]
[3] [...]

> sieve :: [Integer] -> [Integer]
> sieve (x:xs) = x : sieve [y | y<- xs, mod y x > 0]

(sieve [2..]) !! 0

take 10 [100..200] => take 10

To solve 
f :: a -> b

f = h . g
-- c is unlimited
g :: a -> c 
h :: c -> b
-- how many h ask, how many g calcute

3. The square root of r:
Iterate sequence:

[a, f a, f(f a), ...]
f x = (x + r / x)

iterate (f, r) a

:t iterate
iterate :: (a -> a) -> a -> [a]

> within :: Float -> [Float] -> Float
> within eps (x:y:xs)
>   | abs (x - y) < eps = y
>   | otherwise         = within eps (y:xs)

> fibs2 :: [Integer]
> fibs2 = 1:[abs y| y <- tail fibs]