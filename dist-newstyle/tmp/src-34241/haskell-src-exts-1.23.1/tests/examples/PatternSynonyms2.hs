{-# LANGUAGE PatternSynonyms, ScopedTypeVariables, KindSignatures  #-}
module Foo (pattern Single) where



pattern Single x <- [x]
  where Single 4 = [x]
        Single 5 = [x]

pattern Double x = [x]





single :: [a] -> Maybe a
single (Single x) = Just x
single _ = Nothing
