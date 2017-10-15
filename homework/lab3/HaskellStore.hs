{-# LANGUAGE TemplateHaskell #-}

module HaskellStore where
  import Text.Printf
  import Test.QuickCheck
  
  -- jskyzero 2017/09/19
  -- jskyzero@outlook.com
  
  -- Haskell函数程序设计实验三
  -- 打印购物小票
  
  {-
    任何有IO的编程语言，如何输出自己想要的信息都很重要。
    以字符形式输出到命令行的标准输出的话，格式化就很重要。
  -}



--  客户购买的物品用一个三元组列表表示
--  其中每个三元组表示一件商品的名称、数量和单价

type Items = [Item]

type Item = (Name, Amount, Price)

-- name, amount and price per unit of the item

type Name = String -- name of the item

type Amount = Float -- amount, like kg or number

type Price = Float  -- price per unit


customer1 = [("Apple", 2.5, 5.99), ("Bread", 2, 3.5)]

-- 使得小数点保留两位
showFloat :: Float -> String
showFloat x = printf "%.2f" x

-- total price
totalPrice :: Items -> Float
totalPrice [] = 0
totalPrice ((name, amount, price):xs) = amount * price +  (totalPrice xs)




-- printItems :: Items -> IO ()


return []
-- 你可以输入check来运行所有的检查
check = $quickCheckAll