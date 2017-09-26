module Main where
import MyFraction
import Test.QuickCheck


-- ????????????????

test_fraction_prop__ratplus_comm :: Fraction -> Fraction -> Property
test_fraction_prop__ratplus_comm (a,b) (c,d) = b/=0&&d/=0 ==>  (a,b) <+> (c,d) <==> (c,d) <+> (a,b)

test_fraction_prop__ratplus_asso (a,b) (c,d) (e,f) = b/=0&&d/=0&&f/=0 ==>
    ((a,b) <+> (c,d)) <+> (e,f) <==>  (a,b) <+> ((c,d) <+> (e,f))

-- ??????§»?????????????????0?? ??0??1?????¦Ê????????????
test_fraction_prop__ratplus_unit :: Integer -> Integer -> Property
test_fraction_prop__ratplus_unit a b =  a > 0 && b > 0 ==>  (a, b) <+> (-a, b) <==> (0,1)&& (a, b) <+> (0,1) <==> (a, b) 

-- ???????????????
test_fraction_prop__ratminus (a,b) (c,d) = b>0 && d>0 ==> (a,b) <-> (c,d) <==>  (-c,d) <+> (a,b)
    && (a,b) <-> (a,b) <==> (0,1)

-- ????????????
test_fraction_prop__ratdiv (a,b) (c,d) = b>0 && d>0 && c>0 ==>  (a,b) </> (c,d) <==> (a,b) <-*-> (d,c)   


-- ????????¨À????????????
test_fraction_prop__rattimes_comm (a,b) (c,d) = b>0 && d>0 ==>  (a,b) <-*-> (c,d) <==> (c,d) <-*-> (a,b)

test_fraction_prop__rattimes_asso (a,b) (c,d) (e,f) = b/=0&&d/=0&&f/=0 ==>
    ((a,b) <-*-> (c,d)) <-*-> (e,f) <==> (a,b) <-*-> ((c,d) <-*-> (e,f))

test_fraction_prop__rattimes_plus_distr :: Fraction -> Fraction -> Fraction ->Property
test_fraction_prop__rattimes_plus_distr (a,b) (c,d) (e,f) = 
    b > 0 && d > 0 && f > 0 ==>
    (a,b) <-*-> ((c,d) <+> (e,f)) <==> ((a,b) <-*-> (c,d)) <+> ((a,b) <-*-> (e,f))


-- ?§Ø??????????????????????????
test_fraction_prop__priority (a,b) (c,d) (e,f) = b/=0 && d/=0 && f/=0 ==>
    (a,b) <+> (c,d) <-*-> (e,f) <==> (a,b) <+> ((c,d) <-*-> (e,f))

-- ?????
is_normal :: Fraction -> Bool
is_normal (a, b) = b > 0 && gcd a b == 1

test_fraction_prop__normal :: Fraction -> Fraction -> Property
test_fraction_prop__normal (a,b) (c,d) =  b>0 && d > 0 && c>0 ==> is_normal ((a,b)<+>(c,d)) 
    && is_normal ((a,b)<->(c,d)) 
    && is_normal ((a,b)<-*->(c,d)) 
    && is_normal ((a,b)</>(c,d)) 



main = do
    putStrLn " <+> commutative"
    quickCheck (test_fraction_prop__ratplus_comm)

    putStrLn "<+> associative"
    quickCheck (test_fraction_prop__ratplus_asso)

    putStrLn "<+> unit law"
    quickCheck (test_fraction_prop__ratplus_unit)

    putStrLn "<+> and <->"
    quickCheck (test_fraction_prop__ratminus)

    putStrLn "<-*-> and </>"
    quickCheck (test_fraction_prop__ratdiv)

    putStrLn "<-*-> commutative"
    quickCheck (test_fraction_prop__rattimes_comm)

    putStrLn "<-*-> associative"
    quickCheck (test_fraction_prop__rattimes_asso)

    putStrLn "<-*-> distributive over <+>"
    quickCheck (test_fraction_prop__rattimes_plus_distr)

    putStrLn "Result normalized"
    quickCheck (test_fraction_prop__normal)

    putStrLn "Priority defined"
    quickCheck (test_fraction_prop__priority)

