module Bid( 
  count
) where


import Data.Char
import Data.List
import Data.List.Split -- for splitOn

-- data types
type BidData = [(String, Integer)]

-- config
default_separator     = "       "         :: String
default_filePath      = "bids_201711.txt" :: String
default_sucessNumber  = 10                :: Int


readData :: String -> BidData
readData  = 
  map (\(id:price:xs) -> (id, read price :: Integer)) .
  map (\line -> splitOn default_separator line) .
  splitOn "\n" 

countData :: BidData -> [(Integer, String)]
countData = 
  reverse .
  sort .
  map (\(id, price) -> (price, id))

showResult :: [(Integer, String)] -> IO String
showResult bidData = do 
  let successData = take default_sucessNumber bidData
  let maxPrice = "The highest price: " ++ ((show. fst . head) successData)
  let lowPrice = "\nThe lowest price: " ++ ((show. fst . last) successData)
  let avePrice = "\nThe average price: " ++ (show (((fromIntegral . sum . map(\(price, id)-> price)) successData) / (fromIntegral default_sucessNumber)))
  let totalNumber = "\nTotal number: " ++ ((show . length) bidData)
  let successList = "\nSuccess List: \n" ++ showBidData successData 
  return (maxPrice ++ lowPrice ++ avePrice ++ totalNumber ++ successList)
  
showBidData :: [(Integer, String)] -> String
showBidData [] = ""
showBidData((price, id):xs) = id ++ default_separator ++ (show price) ++ "\n" ++ (showBidData xs)

count :: String -> IO ()
count filePath = do
  fileData <- readFile filePath
  result <- showResult $ (countData . readData) fileData
  putStrLn result

main = count default_filePath