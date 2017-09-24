{-# LANGUAGE TemplateHaskell #-}

module MyFraction where
import Test.QuickCheck

-- jskyzero 2017/09/19
-- jskyzero@outlook.com

-- Haskell函数程序设计实验一
-- 实现分数的常用运算并测试


type Fraction = (Integer, Integer)
{-
  什么是分数？
  一个分数可以表示为`(a, b)`，其中`b > 0`, 且a，b没有大于１的公因子。

  分数（Fraction）
  分母（Denominator）
  分子（Numerator）
-}

normalizeFraction :: Fraction -> Fraction
{-
  this function recived a Fraction and reduced it to simple Fraction
  about gcd, you must konw in haskell the value will be non-negative
  so, I use a sign to store the sign and let it be in numerator

  this function use signum, gcd, quot from default function library
-}
normalizeFraction (x, y) = 
  let sign = (if (signum x /= signum y)
              then -1 
              else 1) in
  let unsign_x = abs x in
  let unsign_y = abs y in
  let factor = gcd unsign_x  unsign_y in
  (sign * unsign_x `div` factor, unsign_y `div` factor)

prop_normalizeFraction :: Fraction -> Property
prop_normalizeFraction (x, y) = y /= 0 ==>
  -- 一个分数可以表示为`(a, b)`
  let (new_x, new_y) = normalizeFraction(x, y) in
    (new_y >= 0)  -- 其中`b > 0`
    && ((gcd new_x new_y) == 1) -- 且a，b没有大于１的公因子。
    && (((fromIntegral new_x) / (fromIntegral new_y)) == 
        ((fromIntegral x) / (fromIntegral y)))


ratplus :: Fraction -> Fraction -> Fraction
ratplus (x1, y1) (x2, y2) = 
  normalizeFraction((x1 * y2 + x2 * y1 ), y1 * y2)

prop_ratplus :: Fraction -> Fraction -> Property
prop_ratplus (x1, y1) (x2, y2) = y1 /= 0 ==>
                                 y2 /= 0 ==>
  let (new_x, new_y) = ratplus (x1, y1) (x2, y2) in 
    ((fromIntegral new_x / fromIntegral new_y) == 
     ((fromIntegral x1 / fromIntegral y1 + 
       fromIntegral x2 / fromIntegral y2)::Rational))
-- what is Rational ?
-- Arbitrary-precision rational numbers, 
-- represented as a ratio of two Integer values. 


ratminus :: Fraction -> Fraction -> Fraction
ratminus (x1, y1) (x2, y2) = 
  normalizeFraction((x1 * y2 - x2 * y1 ), y1 * y2)

prop_ratminus :: Fraction -> Fraction -> Property
prop_ratminus (x1, y1) (x2, y2) = y1 /= 0 ==>
                                  y2 /= 0 ==>
  let (new_x, new_y) = ratminus (x1, y1) (x2, y2) in 
    ((fromIntegral new_x / fromIntegral new_y) == 
     ((fromIntegral x1 / fromIntegral y1 - 
       fromIntegral x2 / fromIntegral y2)::Rational))


rattimes :: Fraction -> Fraction -> Fraction
rattimes (x1, y1) (x2, y2) = 
  normalizeFraction((x1 * x2), y1 * y2)

prop_rattimes :: Fraction -> Fraction -> Property
prop_rattimes (x1, y1) (x2, y2) = y1 /= 0 ==>
                                  y2 /= 0 ==>
  let (new_x, new_y) = rattimes (x1, y1) (x2, y2) in 
    ((fromIntegral new_x / fromIntegral new_y) == 
     (((fromIntegral x1 / fromIntegral y1) * 
       (fromIntegral x2 / fromIntegral y2))::Rational))


ratdiv :: Fraction -> Fraction -> Fraction
ratdiv (x1, y1) (x2, y2) = rattimes (x1, y1) (y2, x2)

prop_ratdiv :: Fraction -> Fraction -> Property
prop_ratdiv (x1, y1) (x2, y2) = y1 /= 0 ==>
                                y2 /= 0 ==>
                                x2 /= 0 ==>
  let (new_x, new_y) = ratdiv (x1, y1) (x2, y2) in 
    ((fromIntegral new_x / fromIntegral new_y) == 
     (((fromIntegral x1 / fromIntegral y1) / 
       (fromIntegral x2 / fromIntegral y2))::Rational))

ratfloor :: Fraction -> Integer
ratfloor (x, y) = floor (fromIntegral x / fromIntegral y)

prop_ratfloor :: Fraction -> Property
prop_ratfloor (x, y) = y /= 0 ==>
  let ans = ratfloor (x, y) in
    (fromIntegral ans <= 
     ((fromIntegral x / fromIntegral y)::Rational)) && 
    (fromIntegral (ans + 1) >
     ((fromIntegral x / fromIntegral y)::Rational))


ratfloat :: Fraction -> Float
ratfloat (x, y) =(/) (fromIntegral x) (fromIntegral　y)

prop_ratfloat :: Fraction -> Property
prop_ratfloat (x, y) = y /= 0 ==>
  let ans = ratfloat (x, y) in
    (ans == (fromIntegral x / fromIntegral y))

rateq :: Fraction -> Fraction -> Bool
rateq (x1, y1) (x2, y2) = 
  (((fromIntegral x1 / fromIntegral y1)::Rational) ==　
   ((fromIntegral x2 / fromIntegral y2)::Rational))


-- 优先级　`*` `/` > `+` `-` > `==` 
infix 5 <+>
(<+>) :: Fraction -> Fraction -> Fraction
(<+>) (x1, y1) (x2, y2) = ratplus(x1, y1) (x2, y2)

infix 5 <->
(<->) :: Fraction -> Fraction -> Fraction
(<->) (x1, y1) (x2, y2) = ratminus(x1, y1) (x2, y2)

infix 6 <-*->
(<-*->) :: Fraction -> Fraction -> Fraction
(<-*->) (x1, y1) (x2, y2) = rattimes(x1, y1) (x2, y2)

infix 6 <-/->
(<-/->) :: Fraction -> Fraction -> Fraction
(<-/->) (x1, y1) (x2, y2) = ratminus(x1, y1) (x2, y2)

infix 4 <==>
(<==>) :: Fraction -> Fraction -> Bool
(<==>) (x1, y1) (x2, y2) = rateq(x1, y1) (x2, y2)

prop_rattimes_plus_distr:: Fraction -> Fraction -> Fraction -> Property
prop_rattimes_plus_distr (x1, y1) (x2, y2) (x3, y3) = 
  y1 /= 0 ==> y2/=0 ==> y3/=0 ==>
  (x1, y1) <-*-> ((x2, y2)<-*->(x3, y3)) <==>
  ((x1, y1) <-*-> (x2, y2))<-*->(x3, y3)

return []
check = $quickCheckAll