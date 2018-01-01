module BMI( 
  bmi
) where

bmi :: IO ()
bmi = do
  hello
  cal_bmi

hello :: IO ()
hello = do
  name <- ask "name"
  putStrLn $ "Hello, " ++ name ++ "."

ask :: String -> IO String
ask s = do
  putStrLn $ "Can you tell me your " ++ s ++ "?"
  getLine

cal_bmi :: IO ()
cal_bmi = do
  input <- ask "height"
  let height = read (input) :: Float
  input <- ask "weight"
  let weight = read (input) :: Float
  let user_bmi = weight * weight / height
  if user_bmi < 18.5
  then do
    -- "体重过低"
    let ans = "体重过低"
    putStrLn ans
  else do
    if user_bmi < 24
    -- "体重正常"
    then putStrLn "体重正常"
    -- "肥胖"
    else putStrLn "肥胖"
