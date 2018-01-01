回顾上节课内容。

高阶函数，接受函数作为参数。

map filter foldr foldl

使用高阶函数的思路从新做之前的题目。

今天的内容：重载，（重载是一种多态）

Polymorphism 多态

> length2 :: [a] -> Int
> length2 [] = 0
> length2 (x:xs) = 1 + length xs

wikipedia:
多态（英语：polymorphism）
是指计算机程序运行时，相同的消息可能会送给多个不同的类别之对象，
而系统可依据对象所属类别，引发对应类别的方法，而有不同的行为。
简单来说，所谓多态意指相同的消息给予不同的对象会引发不同的动作称之。

多态可以分为
动态多态
  类继承和虚函数作用与运行期
静态多态：
  非参数化（特设）多态： 函数/运算符重载，带变量的宏多态
  参数化多态：类型作为参数的多态（OOP：泛型编程）

Overloading 重载
(==) :: Eq a -> a -> a -> Bool

class Eq a where
  (==) :: a -> a -> Bool
  (/=) :: a -> a -> Bool
  {-# MINIMAL (==) | (/=) #-}
        -- Defined in `GHC.Classes'
instance Eq a => Eq [a] -- Defined in `GHC.Classes'
instance Eq Word -- Defined in `GHC.Classes'
instance Eq Ordering -- Defined in `GHC.Classes'
instance Eq Int -- Defined in `GHC.Classes'
instance Eq Float -- Defined in `GHC.Classes'
instance Eq Double -- Defined in `GHC.Classes'
instance Eq Char -- Defined in `GHC.Classes'
instance Eq Bool -- Defined in `GHC.Classes'
instance (Eq a, Eq b, Eq c, Eq d, Eq e, Eq f, Eq g, Eq h, Eq i,
          Eq j, Eq k, Eq l, Eq m, Eq n, Eq o) =>
         Eq (a, b, c, d, e, f, g, h, i, j, k, l, m, n, o)
  -- Defined in `GHC.Classes'
instance (Eq a, Eq b, Eq c, Eq d, Eq e, Eq f, Eq g, Eq h, Eq i,
          Eq j, Eq k, Eq l, Eq m, Eq n) =>
         Eq (a, b, c, d, e, f, g, h, i, j, k, l, m, n)
  -- Defined in `GHC.Classes'
instance (Eq a, Eq b, Eq c, Eq d, Eq e, Eq f, Eq g, Eq h, Eq i,
          Eq j, Eq k, Eq l, Eq m) =>
         Eq (a, b, c, d, e, f, g, h, i, j, k, l, m)
  -- Defined in `GHC.Classes'
instance (Eq a, Eq b, Eq c, Eq d, Eq e, Eq f, Eq g, Eq h, Eq i,
          Eq j, Eq k, Eq l) =>
         Eq (a, b, c, d, e, f, g, h, i, j, k, l)
  -- Defined in `GHC.Classes'
instance (Eq a, Eq b, Eq c, Eq d, Eq e, Eq f, Eq g, Eq h, Eq i,
          Eq j, Eq k) =>
         Eq (a, b, c, d, e, f, g, h, i, j, k)
  -- Defined in `GHC.Classes'
instance (Eq a, Eq b, Eq c, Eq d, Eq e, Eq f, Eq g, Eq h, Eq i,
          Eq j) =>
         Eq (a, b, c, d, e, f, g, h, i, j)
  -- Defined in `GHC.Classes'
instance (Eq a, Eq b, Eq c, Eq d, Eq e, Eq f, Eq g, Eq h, Eq i) =>
         Eq (a, b, c, d, e, f, g, h, i)
  -- Defined in `GHC.Classes'
instance (Eq a, Eq b, Eq c, Eq d, Eq e, Eq f, Eq g, Eq h) =>
         Eq (a, b, c, d, e, f, g, h)
  -- Defined in `GHC.Classes'
instance (Eq a, Eq b, Eq c, Eq d, Eq e, Eq f, Eq g) =>
         Eq (a, b, c, d, e, f, g)
  -- Defined in `GHC.Classes'
instance (Eq a, Eq b, Eq c, Eq d, Eq e, Eq f) =>
         Eq (a, b, c, d, e, f)
  -- Defined in `GHC.Classes'
instance (Eq a, Eq b, Eq c, Eq d, Eq e) => Eq (a, b, c, d, e)
  -- Defined in `GHC.Classes'
instance (Eq a, Eq b, Eq c, Eq d) => Eq (a, b, c, d)
  -- Defined in `GHC.Classes'
instance (Eq a, Eq b, Eq c) => Eq (a, b, c)
  -- Defined in `GHC.Classes'
instance (Eq a, Eq b) => Eq (a, b) -- Defined in `GHC.Classes'
instance Eq () -- Defined in `GHC.Classes'
instance (Eq b, Eq a) => Eq (Either a b)
  -- Defined in `Data.Either'
instance Eq Integer
  -- Defined in `integer-gmp-1.0.1.0:GHC.Integer.Type'
instance Eq a => Eq (Maybe a) -- Defined in `GHC.Base'


对类型变量有限制

> data Season = Spring | Summer | Automn | Winter
>   deriving (Show, Eq)

-- > instance Eq Season where
-- >  Spring == Spring = True
-- >  Summer == Summer = True
-- >  Automn == Automn = True
-- >  Winter == Winter = True
-- >  _      == _      = False -- 不关心叫啥2333

运算/符号 重载

> -- myelem :: Int -> [Int] -> Bool
> myelem :: Eq a => a -> [a] -> Bool
> myelem x [] = False
> myelem x (y:ys)
>   | x == y = True
>   | otherwise = myelem x ys


> class Size2 a where
>   size2 :: a -> Int
> instance Size2 Season where
>   size2 _ =  1
> instance Size2 Integer where
>   size2 _ =  1
> instance Size2 Float where
>   size2 _ =  2
> instance Size2 Double where
>   size2 _ =  3

Ord instance compare