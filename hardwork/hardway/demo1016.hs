{-# LANGUAGE TemplateHaskell #-}

import Test.QuickCheck
{-
  函数的符合运算
  Function composition.

已知：
f :: a -> b

g :: b -> c

定义另一个函数：
h :: a -> c
h x = g (f x)

h 就是f和g的复合，记作
h = g . f

-}

f :: Int -> Int
f x = 2 * x

g :: Int -> Int
g x = 2 * x + 1

prop_f_g :: Int -> Bool
prop_f_g x = (f . g) x == f (g x)

prop_g_f :: Int -> Bool
prop_g_f x = (g . f) x == g (f x)

prop_g_f_2 :: Int -> Bool
prop_g_f_2 x =(g . f $ x) == g (f x)

{-
  一个简单的图形处理库

  自底向上
-}
type Picture = [String]

tree = ["   #",
        "  ##",
        " ###",
        "####",
        "   #",
        "   #",
        "   #",
        "   #"]
-- print picture
printPic :: Picture -> IO ()
printPic = putStrLn .unlines

-- picture above
abovePic :: Picture -> Picture -> Picture
abovePic p q = p ++ q 
-- picture side by size
sideBySidePic :: Picture -> Picture -> Picture
sideBySidePic p q = [x ++ y | (x, y) <- zip p q]

flipeVerPic :: Picture -> Picture
flipeVerPic pic = reverse pic

flipeHorPic :: Picture -> Picture
flipeHorPic pic = [ reverse line | line <- pic]

{-
  module Picure (
    Picture
    -- 输出列表
  ) where 
-}

return []
check = $quickCheckAll