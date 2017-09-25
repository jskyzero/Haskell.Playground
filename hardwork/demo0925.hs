f0 :: Int -> Int
f0 x = x

f1 :: Int -> (Int -> Int)
f1 x = f0

f2 :: (Int -> Int) -> Int
f2 f =  f1 0 0


-- polymorphic
second :: (a, b) -> b
second (x, y) = y

-- RSP
data Move = Rock | Scissors | Paper
beat :: Move -> Move -> Bool
beat Paper Rock = True
-- ...
beat _ _ = False

-- Shape
data Shape = Circle Float | Rect Float Float | Square Float
-- Shape 包含 Circle 2.3
area :: Shape -> Float
area (Circle x ) = pi * x ^ 2
area (Rect x y) = x * y
area (Square x ) = x * x


-- resume
-- 0! = 1
-- n! = n * (n - 1)!
fact :: Int -> Int
fact 0 = 1
fact n = n * (fact(n - 1))

fact2 :: (Int, Int) -> Int
fact2 (0, ans) = ans
fact2 (n , ans) = fact2(n - 1, ans * n)

-- 关心最简单的情况，然后递归公式
-- 没有循环

type Person =　String 
type Book = String
type DataBase = [(Person, Book)]

borrow :: DataBase -> Person -> Book -> DataBase
borrow oldBase person book = (person, book):oldBase

return :: DataBase -> Person -> Book -> DataBase
return oldBase person book = [item| item <- oldBase, item /= (person, book)]