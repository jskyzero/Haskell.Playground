module Game (
  play
  ) where

import System.Random

data Hand = Rock | Scissor | Paper deriving (Enum)

play :: IO ()
play = do 
  putStrLn "HelloWorld!"