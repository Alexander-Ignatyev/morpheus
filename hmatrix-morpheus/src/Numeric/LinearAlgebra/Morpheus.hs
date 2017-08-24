{-|
Module: Numeric.LinearAlgebra.Morpheus
Description: Low-level machine learning auxiliary functions
Copyright: (c) Alexander Ignatyev, 2017
License: BSD-3
Stability: experimental
Portability: POSIX
-}

module Numeric.LinearAlgebra.Morpheus
(
  columnSum
  , rowSum
)

where

import Numeric.LinearAlgebra
import Numeric.LinearAlgebra.Devel
import System.IO.Unsafe(unsafePerformIO)
import Foreign.C.Types(CInt(..))
import Foreign.Ptr(Ptr)


morpheusLayout :: CInt -> CInt -> CInt
morpheusLayout xCol cols = if xCol == 1 || cols == 1 then 21 else 22


{- morpheus_column_sum -}
foreign import ccall unsafe "morpheus_column_sum"
  c_morpheus_column_sum :: CInt -> CInt -> CInt -> Ptr Double -> Ptr Double -> IO ()


call_morpheus_column_sum :: CInt -> CInt -> CInt -> CInt -> Ptr Double
                         -> CInt -> Ptr Double
                         -> IO ()
call_morpheus_column_sum rows cols xRow xCol matPtr _ vecPtr = do
  let layout = morpheusLayout xCol cols
  c_morpheus_column_sum layout rows cols matPtr vecPtr


-- | Calculates sums of elements of every column of the given matrix
columnSum :: Matrix Double -> Vector Double
columnSum m = unsafePerformIO $ do
    v <- createVector (cols m)
    apply m (apply v id) call_morpheus_column_sum
    return v


{- morpheus_row_sum -}
foreign import ccall unsafe "morpheus_row_sum"
  c_morpheus_row_sum :: CInt -> CInt -> CInt -> Ptr Double -> Ptr Double -> IO ()


call_morpheus_row_sum :: CInt -> CInt -> CInt -> CInt -> Ptr Double
                      -> CInt -> Ptr Double
                      -> IO ()
call_morpheus_row_sum rows cols xRow xCol matPtr _ vecPtr = do
  let layout = morpheusLayout xCol cols
  c_morpheus_row_sum layout rows cols matPtr vecPtr


-- | Calculates sums of elements of every row of the given matrix
rowSum :: Matrix Double -> Vector Double
rowSum m = unsafePerformIO $ do
    v <- createVector (rows m)
    apply m (apply v id) call_morpheus_row_sum
    return v
