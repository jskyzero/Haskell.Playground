> import System.Random


> a = [1, 2]
> b = [3, 4, 5]
> cp :: [[a]] -> [[a]]
> cp [] = [[]]
> cp (xs:xss) = [x:ys | x <- xs, ys <- yss]
>               where yss = cp xss



cp [a, b]
[[x, y] | x <- a, y <- b]

11/27

带参数的自定义类型

电话簿，查找

类型，构造函数，大写字母开头。

> data MaybeInt = Falure | MyJust Int
> mylookup :: String -> [(String, Int)] -> MaybeInt
> mylookup name [] = Falure
> mylookup name ((na, nm):xs)
>   | name == na = MyJust nm 
>   | otherwise = mylookup name xs

推广lookup，泛化String, Int到 a, b

整数序列的类型
空
整数+整数序列=整数序列

> data IntList = IntNull | IntCons Int IntList

> data List a = Null | Cons a (List a)

今天要看的是IO
目前基本上只接触了输出

IO a is the set of actions and return some a

getChar :: IO -> Char
getLine :: IO -> String
putChar :: Char -> IO ()
putStr :: String -> IO ()
print :: Show a => a -> IO ()
print x = putStrLn (show x)

return :: Monad m => a -> m a

read show
show :: Show a => a -> String
read :: Read a => String -> a

连续动作的表示
do 
  action1
  action2
  action3

> p1 :: IO ()
> p1 = do
>   putStr "Hello"
>   putStr "World!"
> 
> p2 :: IO ()
> p2 = do
>   a <- getChar
>   print a
> 

p3 getLine

> putSeveralChar :: [Char] -> IO ()
> putSeveralChar [] = return ()
> putSeveralChar (x:xs) = do 
>     putChar x
>     putSeveralChar xs
> 
> getInt :: IO Int
> getInt = do
>   line <- getLine
>   return (read line :: Int)
>   -- return (read line)
> addIOInt :: IO ()
> addIOInt = do
>   putStrLn "Put One"
>   a <- getInt
>   putStrLn "Put Another One"
>   b <- getInt
>   putStrLn "The Sum is"
>   print (a + b)

do 是一种语法
在其下可以列动作，动作是函数，有类型
看最后一个动作的类型

> guess :: IO ()
> guess = do 
>   a <- randomIO :: IO Int
>   let n = mod a 101 -- [0, 100]
>   putStrLn "Begin Game"
>   guess_unit n
>
> guess_unit :: Int -> IO ()
> guess_unit ans = do
>   putStrLn "Input Some Number between 0 - 100"
>   num <- getInt
>   if (num == ans)
>   then putStrLn "You Win!"
>   else do
>     if (num < ans)
>     then do
>       putStrLn "Your Input is small"
>       guess_unit ans
>     else do 
>       putStrLn "Yout Input is big"
>       guess_unit ans

guess_unit :: Int -> Int -> IO ()
guess_unit ans round = do

> test :: Int
> test = do
>   let a = 1 + 2
>   abs(a)

用递归实现重复