{-# LANGUAGE TemplateHaskell #-}

module Prop where
import Test.QuickCheck

data Prop = Const Bool
            | Var Char
            | Not Prop
            | And Prop Prop
            | Or Prop Prop
            | Imply Prop Prop
  deriving Eq



return []
-- 你可以输入check来运行所有的检查
check = $quickCheckAll