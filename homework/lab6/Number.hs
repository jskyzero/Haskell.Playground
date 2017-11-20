{-# LANGUAGE TemplateHaskell #-}

module Number where
import Test.QuickCheck


data Nature = Zero | Succ Nature

nat2int :: Nature -> Int
nat2int Zero = 0
nat2int (Succ n) = nat2int n + 1

-- add :: Nature -> Nature -> Nature
-- add Zero Zero = Zero
-- add Zero _ = _
-- add _ Zero = _
-- add left right = left

instance Show Nature where
    show n = show (nat2int n)

return []
-- 你可以输入check来运行所有的检查
check = $quickCheckAll