{-# LANGUAGE TemplateHaskell #-}

module Expression where
import Test.QuickCheck


data Exp = Lit Integer | Add Exp Exp | Sub Exp Exp | Mul Exp Exp

printExp :: Exp -> String
printExp (Lit num)
         | num >= 0 = show num
         | otherwise = addBrackets $ show $ num
printExp (Add left right) = printExpSub left right "+"
printExp (Sub left right) = printExpSub left right "-"
printExp (Mul left right) = printExpSub left right "*"
-- printExp (Div left right) = printExpSub left right "/"


printExpSub :: Exp -> Exp -> String -> String
printExpSub left right operator = addOperatorWithBrackets (printExp left) (printExp right) operator

-- these test make no sense in fact
-- prop_printLitBiggerThanZero :: Integer -> Property
-- prop_printLitBiggerThanZero n = n >= 0 ==>
--                 printExp (Lit n) == show n


{-
  关于输出格式:
  子表达式默认添加括号表明有限级,同时明确唯一表达形式
  为了美观,操作符左右默添加空格
-}
prop_printExpSub :: Bool
prop_printExpSub = printExp (Lit 1) == "1" &&
                   printExp (Lit (-1)) == "(-1)" &&
                   printExp (Add (Lit 3) (Lit 5)) == "(3 + 5)" &&
                  --  2+3+5
                  printExp (Add (Add (Lit 2) (Lit 3)) (Lit 5)) == "((2 + 3) + 5)" &&
                  --  2*3*5
                  printExp (Mul (Mul (Lit 2) (Lit 3)) (Lit 5)) == "((2 * 3) * 5)" &&
                  --  3*(2+4)
                  printExp (Mul (Lit 3) (Add (Lit 2) (Lit 4))) == "(3 * (2 + 4))" &&
                  True

addHeadandTail :: String -> String -> String -> String
addHeadandTail header tail old  = header ++ old ++ tail

addBrackets = addHeadandTail "(" ")"
addSpace = addHeadandTail " " " "

addOperator :: String -> String -> String -> String
addOperator left right operator = left ++ (addSpace operator) ++ right
addOperatorWithBrackets :: String -> String -> String -> String
addOperatorWithBrackets left right operator = addBrackets $ left ++ (addSpace operator) ++ right


instance Show Exp where
  show e = printExp e

return []
-- 你可以输入check来运行所有的检查
check = $quickCheckAll