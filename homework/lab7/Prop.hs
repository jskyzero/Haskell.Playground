{-# LANGUAGE TemplateHaskell #-}

module Prop where
import Test.QuickCheck

data Prop = Const Bool
            | Var Char
            | Not Prop
            | And Prop Prop
            | Or Prop Prop
            | Imply Prop Prop
  deriving (Eq)

-- Part 1 show and const value
instance Show Prop where
  show (Const b) = show b
  show (Var c) = show c 
  show (Not p) = "~" ++ show p
  show (And p1 p2) = addBrackets $ show p1 ++  (addSpace "&&") ++ show p2
  show (Or p1 p2) = addBrackets $ show p1 ++  (addSpace "||") ++ show p2
  show (Imply p1 p2) = addBrackets $ show p1 ++  (addSpace "=>") ++ show p2

p1, p2, p3 :: Prop
p1 = And (Var 'A') (Not (Var 'A'))
p2 = Or (Var 'A') (Not (Var 'A'))
p3 = Imply (Var 'A') (And (Var 'A') (Var 'B'))


prop_testShow :: Bool
prop_testShow = show p1 == "('A' && ~'A')" &&
                show p2 == "('A' || ~'A')" &&
                show p3 == "('A' => ('A' && 'B'))" &&
                True

-- Part2 eval vars subsets




addHeadandTail :: String -> String -> String -> String
addHeadandTail header tail old  = header ++ old ++ tail

addBrackets = addHeadandTail "(" ")"
addSpace = addHeadandTail " " " "

return []
-- 你可以输入check来运行所有的检查
check = $quickCheckAll