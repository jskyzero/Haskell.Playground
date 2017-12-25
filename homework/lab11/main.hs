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


-- instance Functor ((->) a) where
--   fmap = (.)

-- instance Applicative ((->) a) where
--   pure b = (\_ -> b)
--   f <*> g = \x -> f x (g x)

-- instance Monad ((->) a) where
--   f >>= g = \x -> g (f x)



-- instance Functor ((,) a) where
--   fmap f ((,) a) = (,) (f a)

-- instance Applicative ((,) a) where
--   pure b = ((,) a b)
--   ((,) f) <*> ((,) a) = ((,) (f a))

-- instance Monad ((,) a) where
--   ((,) a) >>= f = f a



-- instance Functor [] where
--   fmap f [] = []
--   fmap f (x:xs) = (f x) ++ (fmap f xs)

-- instance Applicative [] where
--   pure a = [a]
--   [] <*> _ = []
--   (f:fs) <*> a = [f x | x<-a ] ++ (fs <*> a)

-- instance Monad [] where
--   [] >>= _ = []
--   (a:as) >>= f = ( f a ) ++ (as >>= f)



-- instance Functor Maybe  where
--   fmap f (Just a) = Just (f a)
--   fmap f Nothing = Nothing

-- instance Applicative Maybe where
--   pure x = Just x
--   Nothing <*> _ = Nothing
--   _ <*> Nothing = Nothing
--   (Just f) <*> (Just a) = Just (f a)

-- instance Monad Maybe where
--   Nothing >>= _ = Nothing
--   (Just a) >>= f = f a



-- instance Functor IO where
--   fmap :: (a -> b) -> IO a -> IO b
--   fmap f x = do
--     k <- x
--     return (f x)

-- instance Applicative IO where
--   pure = return
--   a <*> b = do
--     f <- a 
--     x <- b
--     return (f x)

-- instance Monad IO where
--   a >>= b = do
--     x <- a
--     f x