isEven :: Integer -> Bool
isEven x = (mod x 2) == 0

notEven :: Integer -> Bool
notEven x = not(isEven x)

isOdd :: Integer -> Bool
isOdd x = mod x 2 == 1

add_two_Float :: Float -> Float -> Float
add_two_Float m n = (+) m n

age :: (String, Char, Integer) -> Integer
age (name, gender, a) = let s = 1 in
                        let s = 2 in
                        s where s = 3

