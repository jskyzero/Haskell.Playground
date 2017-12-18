类型，特定元素的集合
类型重载

族（class）

class Ord a where

:i Ord
class Eq a => Ord a where
  compare :: a -> a -> Ordering
  (<)
  (>)
  ...
  max
  min

Monad

class Applicative m => Monad (m :: * -> *) where
  (>>=) :: m a -> (a -> mb) -> mb
  (>>) :: m a -> m b -> m b
  return :: a -> m a
  fail :: String -> m a
class Functor f => Applicative (f :: * -> *) where
  pure :: a -> f a
  (<*>) :: f (a -> b) -> f a -> f b
class Functor (f :: * -> *) where
  fmap :: (a -> b) -> f a -> f b
  (<$) :: a -> f b -> f b

I don't know $ means what in *.lhs file

m :: * -> *, the kind of m
m is a type constructor

Maybe Int, Maybe Bool
Maybe is a type constructor

IO Int, IO String are types
IO is a type constructor

[Int] ([] Int), [Bool] are types
[] is a type constructor
(Int, Int) ((,) Int Bool == (Int, Bool))
(,) Int ((Int, ) is a type constructor)
(->) Int Bool (Int -> Bool), (->) is a type constructor


types' type

:kind Bool
Bool :: *
:kind (,)
(,) :: * -> * -> *
:kind (,) Int
(,) Int :: * -> *

instance Functor Maybe where
  fmap :: (a -> b) -> Maybe a -> Maybe b
  fmap f Nothing Nothing
  fmap f (Just x) = Just (f x)

instance Functor IO where
  fmap :: (a -> b) -> IO a -> IO b
  fmap f x = 
    k <- x
    return (f x)

instance Functor ((,) a) where
  fmap :: (s -> t) -> (a, s) -> (a, t)
  fmap f (x, y) = (x, f y)

instance Functor [] where
  fmap :: (a -> b) [a] -> [b]
  fmap = map

look about either, <->

Applicative
instance Applicative Maybe where
  pure :: a -> Maybe a
  pure x = Just x
  (<*>) :: Maybe (a -> b) -> Maybe a -> Maybe b
  Nothing <*> _ = Nothing
  (Just f) <*> Nothing = Nothing
  (Just f) <*> (Just x) = Just (f x)

instance Applicative [] where
  pure :: a -> [a]
  pure x = [x]
  (<*>) :: [a -> b] -> [a] -> [b]
  -- many ways to do this

instance Monad IO where
  (>>=) :: IO a -> (a -> IO b) -> IO b
  m >>= f = do 
    x <- m'
    f x
  (>>) :: IO a -> IO b -> IO b
  m1 >> m2 = do
    m1
    m2

syntax sugar

> f1 :: Int -> Bool
> f1 x = mod x 2 == 0
> a = [f1, f1] <*> [1..10]
