import Data.Char
import Data.List
import Data.List.Split


isValid :: Integer -> Bool
isValid num = 
  (\num -> mod num 10 == 0) .
  sum .
  map (\num -> 
    if num > 9
      then (mod num 10) + (num `div` 10)
      else num) .
  map (\(index, ch) -> 
    if odd index 
      then (ord(ch) - ord('0')) * 2 
      else (ord(ch) - ord('0'))) .
  zip [0..] .
  reverse .
  show $ num

numValid :: [Integer] -> String
numValid xs = 
  init .
  foldr (++) "" .
  map (\num -> ((show num) ++ "\n")) . 
  foldl (\seen x -> if x `elem` seen
                    then seen
                    else seen ++ [x]) [] .
  sort $ filter isValid xs

numNotValid :: [Integer] -> String
numNotValid xs = 
  init .
  foldr (++) "" .
  map (\num -> ((show num) ++ "\n")) . 
  foldl (\seen x -> if x `elem` seen
                    then seen
                    else seen ++ [x]) [] .
  sort $ filter (not . isValid) xs

readData :: String -> [Integer]
readData = 
  map(\str -> read str :: Integer). 
  splitOn "\n" 

main :: IO ()
main = do
  text <- readFile "cards200.txt"
  let datas = readData text
  writeFile "validCards.txt" (numValid datas)
  writeFile "notValidCards.txt" (numNotValid datas)

f1 :: IO ()
f1 = do
  putStr "Hello"

f2 :: IO String
f2 = return "123"

f3 :: String -> IO String
f3 str = return str

f4 :: String -> IO ()
f4 str = do
  putStr str

f5 :: IO String -> IO ()
f5 datas = do
  str <- datas
  putStr str

f6 :: IO String -> IO String
f6 datas = datas

f7 :: [IO String] -> IO ()
f7 [] = putStr "empty"

f8 :: Show a => a -> IO ()
f8 str = putStr $ show str

f9 :: a -> IO a
f9 datas = return datas