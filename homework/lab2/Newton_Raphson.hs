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

prop_rootIteration :: Float -> Float -> Property
prop_rootIteration square_num x = square_num > 0 ==>
                                  x > 0 ==>
                                  x <= square_num ==>
  let new_x = rootIteration square_num x in 
    abs (square_num - new_x ^ 2) <= abs (square_num - x ^ 2)

return []
check = $quickCheckAll