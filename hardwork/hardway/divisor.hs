isDivisor :: Integer -> Integer -> Bool
isDivisor y x = ((x `mod` y) == 0)

calculateDivisor:: Integer -> Integer -> [Integer]
calculateDivisor x 1 = [1]
calculateDivisor x y = if y `isDivisor` x
                       then y:calculateDivisor x (y - 1)
                       else calculateDivisor x (y - 1)

divisors :: Integer -> [Integer]
divisors x = calculateDivisor x x
