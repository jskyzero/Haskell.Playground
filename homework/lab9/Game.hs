{-# LANGUAGE TemplateHaskell #-}

module Game (
  play,
  check -- for check all
  ) where

import System.Random    -- for Random, random, randomR
import Test.QuickCheck  -- for checkall
import Data.Ord         -- for Ord
import Data.Char        -- for toLower

-- Hand data type
data Hand = Rock | Scissor | Paper 
  deriving (Bounded, Enum, Show, Eq)
-- random
instance Random Hand where
  random g = case randomR (fromEnum (minBound :: Hand), fromEnum (maxBound :: Hand)) g of
          (r, g') -> (toEnum r, g')
  randomR (a,b) g = case randomR (fromEnum a, fromEnum b) g of
          (r, g') -> (toEnum r, g')
instance Ord Hand where
  compare left right
    | left == right = EQ
    | left == Rock    && right == Scissor = GT
    | left == Scissor && right == Paper   = GT
    | left == Paper   && right == Rock    = GT
    | otherwise = LT

prop_compare :: Bool
prop_compare = (Rock < Rock) == False &&
               (Rock <= Rock) == True &&
               (Rock == Rock) == True &&
               (Rock > Rock) == False &&
               (Rock >= Rock) == True &&
               (Rock < Scissor) == False &&
               (Rock < Paper) == True

-- User Hand
data UserHand = ErrorInput | Maybe Hand
      deriving (Show)
-- trans Char to UserHand
charToUserHand :: [(Char, Hand)] -> Char -> IO UserHand
charToUserHand [] _ = return ErrorInput
charToUserHand ((c,h):xs) ch
      | c == (toLower ch) = return (Maybe h)
      | otherwise = charToUserHand xs ch
-- trans table
trans_table = [('r', Rock), 
               ('s', Scissor),
               ('p', Paper)]

-- Round Result
data CompareResult = UserWin | RobootWin | SameHand
      deriving (Eq)
instance Show CompareResult where
  show result 
    | result == UserWin    = "This Round You Win\n"
    | result == RobootWin  = ""
    | result == SameHand   = "This Round is a Draw\n"

compareHand :: Hand -> UserHand -> CompareResult
compareHand roboot (Maybe user)
  | result == EQ = SameHand
  | result == LT = UserWin
  | result == GT = RobootWin
    where result = compare roboot user

-- Scoreboard
updateScoreboard :: (Int, Int) -> CompareResult -> (Int, Int)
updateScoreboard (userScore, robootScore) result 
  | result == UserWin   = (userScore + 1, robootScore)
  | result == RobootWin = (userScore, robootScore + 1)
  | result == SameHand  = (userScore, robootScore)

showScoreboard :: (Int, Int) -> String
showScoreboard (userScore, robootScore) = 
  "Your Score is " ++ (show userScore) ++ "\n" ++ 
  "Roboot Score is " ++ (show robootScore) ++ "\n"

isUserWin :: (Int, Int) -> Bool
isUserWin (userScore, robootScore) = userScore == 3

isRobootWin :: (Int, Int) -> Bool
isRobootWin (userScore, robootScore) = robootScore == 3

showHand :: String -> String -> String
showHand people hand = 
  people ++ " hand is " ++ hand ++ ", "

play :: IO ()
play = do 
  playRound (0, 0)


playRound :: (Int, Int) -> IO ()
playRound (userScore, robootScore) = 
  let scoreTable = (userScore, robootScore) in do
    if isUserWin scoreTable 
    then putStrLn "Cheers, You Win!"
    else do
    if isRobootWin scoreTable 
    then putStrLn "Haha, Roboot Win!"
    else do
    putStr "Please Choose (R)Rock (S)Scissor (P)Paper: "
    choice <- getChar
    userHand <- charToUserHand trans_table choice
    robootHand <- randomIO :: IO Hand
    putStr $ showHand " your" ((\(Maybe hand) -> show hand) userHand)
    putStrLn $ showHand "roboot's" (show robootHand)
    let result = compareHand robootHand userHand
    let newScoreTable = updateScoreboard scoreTable result
    (putStr . show) result
    (putStr . showScoreboard) newScoreTable
    playRound newScoreTable
    -- result = compareHand 

return []
-- 你可以输入check来运行所有的检查
check = $quickCheckAll


{-

some tips:

Case expressions

case expression of pattern -> result  
                   pattern -> result  
                   pattern -> result  
                   ...  

describeList :: [a] -> String  
describeList xs = "The list is " ++ case xs of [] -> "empty."  
                                               [x] -> "a singleton list."   
                                               xs -> "a longer list." 

describeList :: [a] -> String  
describeList xs = "The list is " ++ what xs  
    where what [] = "empty."  
          what [x] = "a singleton list."  
          what xs = "a longer list."
-}