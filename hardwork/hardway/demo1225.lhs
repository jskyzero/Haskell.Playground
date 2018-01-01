惯例点名，询问问题。

:i (->) 
data (->) (a :: TYPE q) (b :: TYPE r)

(->) :: * -> * -> * -- 是一个函数
(->) Int :: * -> *
(->) Int Int :: *

Int -> Int === (->) Int Int
1 + 1 === (+) 1 2

(->) a :: * -> *
a is type variable, (->) is type function

(,) a === (a, _)
(,) a b === (a, b)

Maybe :: * -> *

Class Overloading 进一步的认识。

instance Functor (->) r where
  fmap :: (a -> b) -> ( r -> a) -> (r -> b)
  fmap f g = \x -> f ( g x)
  fmap f g = \x -> (f . g) x
  -- fmap f g = f . g

需要验证定律（law）是否成立

不等是相等的否定
class Eq a where
  (/=) = not =

-- 算不出值
eval :: Exp -> Maybe Int
-- 想记录额外信息，状态S  能表达这些effects的类型
eval :: Exp -> (S -> (a, S))
抽象但是普遍适用

-- state monad
type M a = (S -> (a, S))


> safeDiv :: Maybe Int -> Maybe Int -> Maybe Int
> safeDiv x Nothing = Nothing
> safeDiv Nothing x = Nothing
> safaDic (Just x) (Just y) = if y == 0 then Nothing else Just (div x y)

> (//) :: Maybe Int -> Maybe Int -> Maybe Int
> -- x // y = x >>= (\a -> y >>= (\b -> if b == 0 then Nothing else Just (div a b)))
> x // y = do
>   a <- x
>   b <- y
>   if b == 0 then Nothing else Just (div a b)

a is Nothing, >>= 的定义会让最终结果为Nothing

简洁美观，便于维护。

写出非常漂亮的parser

print :: Exp -> String
parser :: String -> Exp

"2 + 3" --> Add (Con 2) (Con 3)


最后一次课
Features

Statically typed: expressions has type determined at compile time.
Purely functional: function is a function in the mathematical sense, no statements or instructions.
Type inference: don't have to explicitly write out every type.
Concurrent: 并行，多核，大数据
Lazy: when need, evaluate
Package: many packages

DSL: domain sepecific language
不同领域，不同语言。更加实用，更加方便。
SQL XML JSON YML LaTeX verilog 
EDSL 嵌入

Agda: dependently typed functional programming language, use in math 
构造性数学的基础，表达能力足够强，正确性带有证明。

写C++函数，模仿函数式程序设计，参数在参数表里面，一般要引用，可以考虑输出就是返回值。

新年快乐，谢谢坚持。

最后测验，开卷，纸质资料可以带。

进一步学习，欧洲某些学校。国际性的学术会议，大家在做什么研究。

具体应用，还是很多的。
