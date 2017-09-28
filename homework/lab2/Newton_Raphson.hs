{-# LANGUAGE TemplateHaskell #-}

module Newton_Raphson where
import Test.QuickCheck

-- jskyzero 2017/09/19
-- jskyzero@outlook.com

-- Haskell函数程序设计实验二
-- 使用牛顿-拉弗森方法求平方根

{-
  牛顿-拉弗森方法（英语：Newton-Raphson method），
  它是一种在实数域和复数域上近似求解方程的方法。
  方法使用函数 f(x)的泰勒级数的前面几项来寻找方程 f(y)=0的根。

  迭代公式 f(x(n+1)) = x(n) - f(x(n)) / f'(x(n))
-}


-- x(n+1) = ( x(n) + square_num / x(n) ) / 2
rootIteration :: Float -> Float -> Float
rootIteration square_num x = (x + square_num / x ) / 2

prop_rootIteration :: Float -> Int -> Property
prop_rootIteration square_num x = 
  square_num > 0 ==>
  x > 0 ==>
  (fromIntegral x) <= square_num ==>
  let new_x_1 = rootIteration square_num (fromIntegral x) in 
  let new_x_2 = rootIteration square_num new_x_1 in 
-- 迭代会越来越接近解
    abs (sqrt square_num - new_x_2) <= abs (sqrt square_num - new_x_1)

squareroot2 :: Float -> Integer -> Float
squareroot2 square_num 0 = 1
squareroot2 square_num n = rootIteration square_num (squareroot2 square_num (n - 1))

-- 迭代值只会越来越靠近真实值
prop_squareroot2 :: Float -> Integer -> Property
prop_squareroot2 square_num n = 
  square_num > 0 ==>
  n > 0 ==>
  let new_x_1 = squareroot2 square_num n in 
  let new_x_2 = squareroot2 square_num (n + 1) in 
-- the iteration will make ans more like sqrt ans
    abs (sqrt square_num - new_x_2) <= abs (sqrt square_num - new_x_1)


squareroot :: Float -> Float -> Integer -> Float
squareroot square_num initial_x 0 = initial_x
squareroot square_num initial_x n = 
  rootIteration square_num (squareroot square_num initial_x (n - 1))

-- 迭代值只会越来越靠近真实值
prop_squareroot :: Float -> Float-> Integer -> Property
prop_squareroot square_num initial_x n = 
  square_num > 0 ==>
  n > 0 ==>
  let new_x_1 = squareroot square_num initial_x n in 
  let new_x_2 = squareroot square_num initial_x (n + 1) in 
-- the iteration will make ans more like sqrt ans
    abs (sqrt square_num - new_x_2) <= abs (sqrt square_num - new_x_1)


sqrtSeq :: Float -> Float -> [Float]
sqrtSeq square_num initial_x = 
  [squareroot square_num initial_x n | n <- [0 .. ]]

-- 第N个值提出来就是单独对第N个求值
prop_sqrtSeq :: Float -> Float -> Integer -> Property
prop_sqrtSeq square_num initial_x n = 
  square_num > 0 ==>
  n >= 0 ==>
  ((sqrtSeq square_num initial_x)!! (fromIntegral n)) == (squareroot square_num initial_x n) 

squareroot' :: Float -> Float -> Float -> Float
squareroot' square_num initial_x epsilon = 
  let sqrt_seq = sqrtSeq square_num initial_x in
    head [ sqrt_seq !! x | x <- [1 .. ], abs(sqrt_seq !! x - sqrt_seq !! (x - 1)) < epsilon]

-- 求到了解再迭代临近两项只差小于epsilon
prop_squareroot' :: Float -> Float -> Float -> Property
prop_squareroot' square_num initial_x epsilon = 
  square_num > 0 ==>
  epsilon > 0 ==>
  let new_x_1 = squareroot' square_num initial_x epsilon in
  let new_x_2 = rootIteration square_num new_x_1 in 
    abs (new_x_2 - new_x_1) < epsilon

return []
-- 你可以输入check来运行所有的检查
check = $quickCheckAll
