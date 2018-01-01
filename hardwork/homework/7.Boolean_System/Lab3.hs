{-# LANGUAGE TemplateHaskell #-}

module Lab3( 
  Prop(..),
  p1,
  p2,
  p3,
  isTaut, -- :: Prop ->Bool 
  vars, -- :: Prop -> [Char]
  substs, -- :: Prop -> [Subst]
  eval,-- :: Subst -> Prop -> Bool
  check
) where
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


prop_show :: Bool
prop_show = show p1 == "('A' && ~'A')" &&
                show p2 == "('A' || ~'A')" &&
                show p3 == "('A' => ('A' && 'B'))" &&
                True

-- Part2 eval vars subsets
type Subst = [(Char, Bool)]
eval :: Subst -> Prop -> Bool
eval sub (Const b) = b
eval sub (Var c) = head [value | (key, value)<-sub, c == key]
eval sub (Not p) = not (eval sub p)
eval sub (And p1 p2) = (eval sub p1) && (eval sub p2)
eval sub (Or p1 p2) = (eval sub p1) || (eval sub p2)
eval sub (Imply p1 p2) = (not (eval sub p1)) || (eval sub p2)


prop_eval :: Bool
prop_eval =  (eval [('A', True),('B', False)] p3 == False) &&
             (eval [('A', True)] p1 == False) &&
             (eval [('A', True)] p2 == True) &&
             True

vars :: Prop -> [Char]
vars (Const b) = []
vars (Var c) = [c]
vars (Not p) = vars p
vars (And p1 p2) = joinStringDeleteDup (vars p1) (vars p2)
vars (Or p1 p2) =  joinStringDeleteDup (vars p1) (vars p2)
vars (Imply p1 p2) = joinStringDeleteDup (vars p1) (vars p2)

prop_vars :: Bool
prop_vars = (vars p3 == "BA") &&
            (vars p1 == "A") &&
            (vars p2 == "A") &&
            True


charInString = any . (==)
joinStringDeleteDup :: [Char] -> [Char] -> [Char]
joinStringDeleteDup [] right = right
joinStringDeleteDup (x:xs) right = if charInString x right
                                    then joinStringDeleteDup xs right
                                    else joinStringDeleteDup xs (right ++ [x])

-- check join two string and remove duplicates
prop_joinStringDeleteDup :: [Char] -> [Char] -> Property
prop_joinStringDeleteDup s1 s2 = 
    -- join s1 to s2
    length s2 == length (removeDuplicates  s2) ==> 
    ((joinStringDeleteDup s1 s2 ) == removeDuplicates(s2 ++ s1))

removeDuplicates :: Eq a => [a] -> [a]
removeDuplicates = rdHelper []
    where rdHelper seen [] = seen
          rdHelper seen (x:xs)
              | x `elem` seen = rdHelper seen xs
              | otherwise = rdHelper (seen ++ [x]) xs

-- this substs maybe don't need test, because, it just list all
substs :: Prop -> [Subst]
substs p = let v = vars p in
           let t = produceTable (length v) in
           [ zip v line | line <- t]

produceTable :: Int -> [[Bool]]
produceTable n
  | n <= 0 = [[]]
  | otherwise = let old = produceTable (n - 1) in
                [[True] ++ each | each<-old] ++ [[False] ++ each | each <-old]


addHeadandTail :: String -> String -> String -> String
addHeadandTail header tail old  = header ++ old ++ tail

addBrackets = addHeadandTail "(" ")"
addSpace = addHeadandTail " " " "

-- Part3
isTaut :: Prop -> Bool
isTaut p = allTrue $
         map (\s -> eval s p) $
         substs p

allTrue :: [Bool] -> Bool
allTrue [] = True
allTrue (x:xs) = if x then allTrue xs else False

prop_isTaut :: Bool
prop_isTaut = (isTaut p2 == True) &&
               (isTaut p1 == False) &&
               True

return []
-- 你可以输入check来运行所有的检查
check = $quickCheckAll