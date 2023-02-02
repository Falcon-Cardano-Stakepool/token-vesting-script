{-# LANGUAGE CPP #-}
{-# LANGUAGE NoRebindableSyntax #-}
{-# OPTIONS_GHC -fno-warn-missing-import-lists #-}
{-# OPTIONS_GHC -w #-}
module Paths_cardano_ledger_shelley_test (
    version,
    getBinDir, getLibDir, getDynLibDir, getDataDir, getLibexecDir,
    getDataFileName, getSysconfDir
  ) where


import qualified Control.Exception as Exception
import qualified Data.List as List
import Data.Version (Version(..))
import System.Environment (getEnv)
import Prelude


#if defined(VERSION_base)

#if MIN_VERSION_base(4,0,0)
catchIO :: IO a -> (Exception.IOException -> IO a) -> IO a
#else
catchIO :: IO a -> (Exception.Exception -> IO a) -> IO a
#endif

#else
catchIO :: IO a -> (Exception.IOException -> IO a) -> IO a
#endif
catchIO = Exception.catch

version :: Version
version = Version [0,1,0,0] []

getDataFileName :: FilePath -> IO FilePath
getDataFileName name = do
  dir <- getDataDir
  return (dir `joinFileName` name)

getBinDir, getLibDir, getDynLibDir, getDataDir, getLibexecDir, getSysconfDir :: IO FilePath



bindir, libdir, dynlibdir, datadir, libexecdir, sysconfdir :: FilePath
bindir     = "/home/ubuntu/.cabal/store/ghc-8.10.7/cardano-ledger-shelley-test-0.1.0.0-6b9d3174a2c29c0ff30b84290e2136252a8cb33a67f142d18f8adf3d695c02a6/bin"
libdir     = "/home/ubuntu/.cabal/store/ghc-8.10.7/cardano-ledger-shelley-test-0.1.0.0-6b9d3174a2c29c0ff30b84290e2136252a8cb33a67f142d18f8adf3d695c02a6/lib"
dynlibdir  = "/home/ubuntu/.cabal/store/ghc-8.10.7/cardano-ledger-shelley-test-0.1.0.0-6b9d3174a2c29c0ff30b84290e2136252a8cb33a67f142d18f8adf3d695c02a6/lib"
datadir    = "/home/ubuntu/.cabal/store/ghc-8.10.7/cardano-ledger-shelley-test-0.1.0.0-6b9d3174a2c29c0ff30b84290e2136252a8cb33a67f142d18f8adf3d695c02a6/share"
libexecdir = "/home/ubuntu/.cabal/store/ghc-8.10.7/cardano-ledger-shelley-test-0.1.0.0-6b9d3174a2c29c0ff30b84290e2136252a8cb33a67f142d18f8adf3d695c02a6/libexec"
sysconfdir = "/home/ubuntu/.cabal/store/ghc-8.10.7/cardano-ledger-shelley-test-0.1.0.0-6b9d3174a2c29c0ff30b84290e2136252a8cb33a67f142d18f8adf3d695c02a6/etc"

getBinDir     = catchIO (getEnv "cardano_ledger_shelley_test_bindir")     (\_ -> return bindir)
getLibDir     = catchIO (getEnv "cardano_ledger_shelley_test_libdir")     (\_ -> return libdir)
getDynLibDir  = catchIO (getEnv "cardano_ledger_shelley_test_dynlibdir")  (\_ -> return dynlibdir)
getDataDir    = catchIO (getEnv "cardano_ledger_shelley_test_datadir")    (\_ -> return datadir)
getLibexecDir = catchIO (getEnv "cardano_ledger_shelley_test_libexecdir") (\_ -> return libexecdir)
getSysconfDir = catchIO (getEnv "cardano_ledger_shelley_test_sysconfdir") (\_ -> return sysconfdir)




joinFileName :: String -> String -> FilePath
joinFileName ""  fname = fname
joinFileName "." fname = fname
joinFileName dir ""    = dir
joinFileName dir fname
  | isPathSeparator (List.last dir) = dir ++ fname
  | otherwise                       = dir ++ pathSeparator : fname

pathSeparator :: Char
pathSeparator = '/'

isPathSeparator :: Char -> Bool
isPathSeparator c = c == '/'
