{-# LANGUAGE TemplateHaskell #-}

module Number where
import Test.QuickCheck


data Nature = Zero | Succ Nature

nat2int :: Nature -> Int
nat2int Zero = 0
nat2int (Succ n) = nat2int n + 1

-- 测试数字，包含嵌套情况
prop_nat2int :: Bool
prop_nat2int = (nat2int Zero == 0) &&
               (nat2int (Succ Zero) == 1) &&
               (nat2int (Succ (Succ Zero)) == 2)

add :: Nature -> Nature -> Nature
add Zero right = right
add (Succ left) right = add left (Succ right)
-- 测试加法,包括全Zero 左/右边是嵌套表达式的情况
prop_add :: Bool
prop_add = ((nat2int(add Zero Zero)) == 0) &&
           ((nat2int(add (Succ Zero) Zero)) == 1) &&
           ((nat2int(add Zero (Succ Zero))) == 1) &&
           ((nat2int(add (Succ Zero) (Succ Zero))) == 2)

instance Show Nature where
    show n = show (nat2int n)


return []
-- 你可以输入check来运行所有的检查
check = $quickCheckAll