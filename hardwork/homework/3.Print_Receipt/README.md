```
请设计一个在屏幕输出客户购物小票的程序。客户购买的物品用一个三元组列表表示，其中
每个三元组表示一件商品的名称、数量和单价，例如，

customer1 = [("Apple", 2.5, 5.99), ("Bread", 2, 3.5)]

为此，我们定义如下类型

type Items = [Item]

type Item = (Name, Amount, Price)

-- name, amount and price per unit of the item

type Name = String -- name of the item

type Amount = Float -- amount, like kg or number

type Price = Float  -- price per unit


请你设计如下函数：：

printItems :: Items -> IO ()

使得

printItems customer1

将会按照如下格式在屏幕输出小票：


Name   Amount  Price  Sum
Apple   2.50   5.99   14.97
Bread   2.00   3.50   7.00
Total  .............. 21.97



以customer1为例，几点提示（当然，你不一定按照提示方法做）：

1. 你可以先设法把输入转化为一个String，如

“Name   Amount  Price  Sum\nApple   2.50   5.99   14.97\nBread   2.00   3.50   7.00\nTotal  .............. 21.97\n”

这样你便可用函数putStr()得到期望的结果。注意其中插入的换行符"\n"。


2. 为此，你可能想把输入转化为类型[String]的数据：

[“Name   Amount  Price  Sum", "Apple   2.50   5.99   14.97", "Bread   2.00   3.50   7.00", "Total  .............. 21.97”],

因为用函数unlines便可得到第1个目标的输入。


3. 将Float转化为String可用show。但是，为了使得小数点保留两位，你可以用下列格式化

函数：


showPre :: Float -> String

showPre x = printf "%.2f" x

为此，你需要先

import Text.Printf
提交要求：
1. 模块命名：
module HaskellStore where
import Text.Printf
 -- 学号姓名
2. 说明你做了哪些测试，有什么问题；
3. 用附件提交，确保其他同学能够运行你的代码。
```