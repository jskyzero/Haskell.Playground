{-

1. 将Maybe, IO, [], (,) a, (->) a定义为Functor的instance;
2. 将Maybe, IO, [], (,) a, (->) a定义为Applicative的instance;
3. 将Maybe, IO, [], (,) a, (->) a定义为Monad的instance.

class Functor (f :: * -> * ) where
  fmap :: (a -> b) -> f a -> f b

class Functor f => Applicative (f :: * -> *) where
  pure :: a -> f a
  (<*>) :: f (a -> b) -> f a -> f b

class Applicative m => Monad (m :: * -> *) where
  (>>=) :: m a -> (a -> m b) -> m b

-}

instance Functor IO where
  fmap :: (a -> b) -> IO a -> IO b
  fmap f x = do
    k <- x
    return (f x)