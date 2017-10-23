import Data.List

{-

0. use hoogle
1. make list base on given lists and items

xs= [1, 2, 3]
1) 23 : xs
2) take 2 xs ++ [23]
3) drop 2 xs ++ [23]

3. highter order functions

e.g.
(.) :: (b -> c) -> (a -> b) -> a -> c

一般是某种计算模式的抽象

[f x | x <- xs], f 是一个函数，xs是一个列表
map :: (a -> b) -> [a] -> [b]
map f [] = []
map f (x:xs) = f x : map f xs

[2 * x | x <- [1..20]] = map double [1..20]
double x = 2 * x

flipV pic = map reverse pic
flipV = map reverse

lambda 表达式
double x = 2 * x
double = \x -> 2 * x, lambda表达式

*Main> :t filter
filter :: (a -> Bool) -> [a] -> [a]
filter p [] = []
filter p (x:xs)
  | p x = x : filter p xs
  | otherwise = filter p xs

3)fold 

sum :: [Int] -> Int
sum [] = 0
sum (x:xs) = x + sum xs

product :: [Int] -> Int
product :: [] = 1
product :: (x:xs) = x * produce xs

*Main> :t foldr
foldr :: Foldable t => (a -> b -> b) -> b -> t a -> b
my_foldr :: (a -> a ->a) -> a -> [a] -> a
my_foldr f last_value [] = last_value
my_foldr f last_value (x:xs) = x `f` (my_foldr f last_value xs)
-}

f :: Int -> Int
f x
  | ((\x -> (mod x 2) == 1) x) = 1
  | True = 0

  -- f2 :: String -> [(String, Int)]
  -- f2 xs =  
  --  --  map (\(w, n) -> w ++ show n) .
  --   map (\ws -> (head ws, length ws)) .
  --   groupBy (==) .
  --   sort .
  --   words $ xs

-- f2 :: String -> String
-- f2 xs =  
--   map (\(w, n) -> w ++ (show n)) .
--   map (\ws -> (head ws, length ws)) .
--   groupBy (==) .
--   sort .
--   words $ xs