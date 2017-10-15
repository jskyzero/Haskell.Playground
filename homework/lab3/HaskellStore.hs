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
-- name, amount and price per unit of the item

-- name of the item
type Name = String 
-- amount, like kg or number
type Amount = Float 
-- price per unit
type Price = Float  

type Item = (Name, Amount, Price)
type Items = [Item]





customer1 = [("Apple", 2.5, 5.99), ("Bread", 2, 3.5)]

-- 使得小数点保留两位
showFloat :: Float -> String
showFloat x = printf "%6.2f" x
-- 测试各种长度的输入
prop_showFloat :: Bool
prop_showFloat = ((showFloat 0.11) == "  0.11") && 
                 ((showFloat 0.111) == "  0.11") && 
                 ((showFloat 52.1) == " 52.10") && 
                 ((showFloat 123.123) == "123.12") && 
                 ((showFloat 1233.123) == "1233.12")

-- total price
totalPrice :: Items -> Float
totalPrice [] = 0
totalPrice ((name, amount, price):xs) = amount * price +  (totalPrice xs)
-- 测试计算总价
prop_totalPrice :: Bool
prop_totalPrice = abs ((totalPrice customer1) - 21.97) <= 0.01
-- 注意判断相等的方法

-- 打印总价
showTotalPrice :: Items -> String
showTotalPrice itemsList = "Total  .............." ++ showFloat (totalPrice itemsList)
-- 测试打印内容
prop_showTotalPrice :: Bool
prop_showTotalPrice = showTotalPrice customer1 ==
  "Total  .............. 21.97"

-- 打印报表头
showHeader :: String
showHeader = "Name   Amount  Price  Sum" ++ "\n"

-- 打印单行
showItem :: Item -> String
showItem (n, a, p) = n ++ " " 
  ++ showFloat a ++ " " ++ showFloat p ++ "  "  ++  showFloat (a * p) ++ "\n"

showItems :: Items -> String
showItems [] = ""
showItems (item:xs) = showItem item ++ showItems xs
-- printItems :: Items -> IO ()

printItems :: Items -> IO ()
printItems itemsList = putStrLn(showHeader ++ showItems itemsList 
                                ++ showTotalPrice itemsList)
prop_printItems :: Bool
prop_printItems = (showItems customer1) == 
  "Apple   2.50   5.99   14.97\nBread   2.00   3.50    7.00\n"

{-

本代码输入如下：注意sum的的7.00的对齐是右对齐

Name   Amount  Price  Sum
Apple   2.50   5.99   14.97
Bread   2.00   3.50    7.00
Total  .............. 21.97

-}

return []
-- 你可以输入check来运行所有的检查
check = $quickCheckAll