各位同学,晚上好!准备!

1. 什么是多态,什么是重载?

多态和重载,优点是自由

类型族的实例,约束

Prelude> :t (+)
(+) :: Num a => a -> a -> a

class 班级
每位同学都有这些功能.
Num : (+) (-) (*) (/)

2. 定义一个排序函数:

sort :: [Int] -> [Int]

插入排序
看前缀, 前缀有序, 增加一个, 插入进去, 仍然有序.

单态函数

> insert_sort :: Ord a => [a] -> [a]
> insert_sort [] = []
> insert_sort [x] = [x]
> insert_sort (x : xs) = insert x ys
>   where ys = insert_sort xs
>
> insert :: Ord a => a -> [a] -> [a]
> insert x [] = [x]
> insert x (y:ys) 
>  |  x <= y    = x : (y:ys)
>  |  otherwise = y: (insert x ys)

快速排序

[3, 1, 3, 2, 4, 2, 5]
3 [1, 3, 2, 2] [3] [4, 5]

1 [1] [3, 2, 2] [1] []
3 [2, 2] [3] []
2 [2] [2] []

4 [] [4] [5]

> quick_sort:: Ord a => [a] -> [a]
> quick_sort [] = []
> quick_sort [x] = [x]
> quick_sort (x:xs) = (quick_sort [n|n<-xs, n<x]) ++ [x] ++ (quick_sort [n|n<-xs, n>=x])
> -- you can make it better to read, use let and where

查找

> type Item  = (String, Integer)
> type Items = [Item]
>
> -- data Maybe a = Just a | Nothing
> --    dervivng Show
> data Find_result = FindJust Integer | FindNothing
>    deriving Show
> -- String Eq 
> find_item :: Items -> String -> Find_result
> find_item ((x,y) : xs) name
>   | x == name = FindJust y
>   | otherwise = find_item xs name
> find_item [] name = FindNothing
>
> itemsData :: Items
> itemsData = [("Jack", 0), ("Make", 1)]
>

Maybe a = FindJust a | Nothing

Prelude> :i Maybe
data Maybe a = Nothing | Just a         -- Defined in ‘GHC.Base’
instance Applicative Maybe -- Defined in ‘GHC.Base’
instance Eq a => Eq (Maybe a) -- Defined in ‘GHC.Base’
instance Functor Maybe -- Defined in ‘GHC.Base’
instance Monad Maybe -- Defined in ‘GHC.Base’
instance Monoid a => Monoid (Maybe a) -- Defined in ‘GHC.Base’
instance Ord a => Ord (Maybe a) -- Defined in ‘GHC.Base’
instance Show a => Show (Maybe a) -- Defined in ‘GHC.Show’
instance Read a => Read (Maybe a) -- Defined in ‘GHC.Read’
instance Foldable Maybe -- Defined in ‘Data.Foldable’
instance Traversable Maybe -- Defined in ‘Data.Traversable’

Prelude> :t Just
Just :: a -> Maybe a

Nat

> data Nature = Zero | Succ Nature
>   -- deriving Show
> nat2int :: Nature -> Int
> nat2int Zero = 0
> nat2int (Succ n) = nat2int n + 1
> 
> instance Show Nature where
>     show n = show (nat2int n)

表示所有表达式的类型

> data Expression = Element | Add Expression Expression | Sub Expression Expression
>                           | Mul Expression Expression | Div Expression Expression
>   deriving Show



