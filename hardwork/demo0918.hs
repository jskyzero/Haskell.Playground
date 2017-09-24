import Test.QuickCheck

myMax :: Int -> Int -> Int
myMax x y = if x > y 
    then x 
    else y
-- not do like
-- myMax 12 34 = 34
-- you must define output for every input

getName :: (String, Char, Int) -> String
-- name, "name"　are different
-- getName ("name", sex, age) = "name"
getName (name, sex, age) = name

myNot :: Bool -> Bool
myNot True = False
myNot False = True
-- myNot x = not x

myMax2 :: Int -> Int -> Int
myMax2 x y
  | x > y = x
  | x < y = y
  | otherwise = x
-- 顺序，先上后下

-- Curry form, haskell curry
mult :: Int -> Int -> Int
mult x y = x * y
-- Uncurried form
mult2 :: (Int, Int) -> Int
mult2 (x, y) = x * y 

data Season = Spring | Summer | Fall | Winter 
              deriving (Show, Eq)

next :: Season -> Season
next Spring = Summer
next Summer = Fall
next Fall = Winter
next Winter = Spring

isHot :: Season -> Bool
isHot Summer = True
isHot _ = False
-- 并不使用

fact :: Integer -> Integer
fact 0 = 1
fact n = n * fact(n - 1)

prop_myMax :: Int -> Int -> Bool
prop_myMax x y = myMax x y >= x && myMax x y >= y
-- prop_myMax :: Int -> Int -> Property
-- prop_myMax x y = x > 0 ==> myMax x y >= x && myMax x y >= y