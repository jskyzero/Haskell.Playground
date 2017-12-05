> import System.Random
> import Data.Char

就，先点个名字。

IO ()
IO String

() is a type, a set of values
()::()   -- so in fact just one value, no return value
string is also a type


> instanceOfIOString :: IO String
> instanceOfIOString = do 
>   putStrLn "Hello"
>   let a = "123"
>   return ("12" ++ "3")

pure math faction, f(input) = outoput, no side efforts

but, IO can be saitificied.
so we introduce `IO ()` which is a type, means a set of actions(do some io), and finally return value with type`()`

return :: Monad m => a -> m a
return :: a => IO a
return "hello" :: IO String


we have a grammer named `do`

several_actions :: IO ()
several_actions = do
  action1
  action2
  actions

> ex1 :: IO ()
> ex1 = do
>   putStr "Input Your Name:"
>   line <- getLine -- IO String
>   putStrLn ("Hello, " ++ line)
>
> ex2 :: IO String
> ex2 = do
>   putStr "Input your name:"
>   getLine


hangman game

> guess :: IO ()
> guess = do
>   let w = "Haskell"
>   guessWord w
>
> guessWord :: String -> IO ()
> guessWord w = do 
>   putStr "Guess $"
>   line <- getLine
>   if line == w
>   then putStrLn "Right!"
>   else do 
>    -- let diff = showDiff w 
>    let diff = [ if input == ans then input else '-' | (input, ans)<-(zip w line)]
>    putStrLn diff
>    guessWord w
>
> showDiff :: String -> String -> String
> showDiff [] _ = []
> showDiff xs [] = ['-'| x <- xs]
> showDiff (x:xs) (y:ys)
>   | x == y = [x] ++ showDiff xs ys
>   | otherwise = "-" ++ showDiff xs ys

> randomInt :: IO Int
> randomInt = do
>   num <- (randomIO :: IO Int)
>   return num
> randomChar :: IO Char
> randomChar = do 
>   random_int <- randomInt
>   let letterCase = mod random_int 2
>   random_int <- randomInt
>   let letter     = mod random_int 26
>   let ans = if letterCase == 1
>             then letter + ord 'a'
>             else letter + ord 'A'
>   return (chr ans)


> randomString :: Int -> IO String
> randomString 0 = return []
> randomString length = do
>   ch <- randomChar
>   last <- randomString (length - 1)
>   let ans = [ch] ++ last
>   return ans

readFile
readFile :: FilePath -> IO String
writeFile
writeFile :: FilePath -> String -> IO ()
appendFile
appendFile :: FilePath -> String -> IO ()

hand instance of random
filter card number