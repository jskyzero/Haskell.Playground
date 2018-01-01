自定义类型，类型的方法

> data Season = Spring | Summer | Fall | Winter
>   deriving (Eq, Show)

可以修改实例的方法

当类型的数目有无穷多个，有限的规则生成无穷的数

> data Nature = Zero | Succ Nature
>   deriving (Eq, Show)
>
> add :: Nature -> Nature -> Nature
> add Zero n = n
> add (Succ m) n = Succ (add m n)

type of expressions, 2, 2+3, 2*4+5

variable is a expression =>

> data Exp = Val Int | Add Exp Exp | Mul Exp Exp | Var String
>   deriving (Eq)
> instance Show Exp where
>   show (Val n) = show n 
>   show (Add a b) = show a ++ " + " ++ show b
>   show (Mul a b) = show a ++ " * " ++ show b
>   show (Var y) = y

show 函数 中的括号，是否显示需要额外信息


[(String, Int)] : a list variables and their subsituted values

> eval :: Exp -> [(String, Int)] -> Int -- can use Maybe
> eval (Val n) sub = n
> eval (Add left right) sub = (eval left sub) + (eval right sub)
> eval (Mul left right) sub = (eval left sub) + (eval right sub)
> eval (Var x) sub = head [value | (title, value)<-sub, title == x]

-- eval (Var "x") [("x", 1)]

haskell的惰性求值（SICP中的提到的正则序？
> self :: a -> a
> self p = self p
> test :: Int -> Int -> Int
> test x y
>   | x == 0 = 0
>   | otherwise  = y

test 0 (self 1)