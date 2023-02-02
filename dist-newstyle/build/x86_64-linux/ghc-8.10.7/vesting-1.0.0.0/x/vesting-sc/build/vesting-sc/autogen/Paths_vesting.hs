{-# LANGUAGE CPP #-}
{-# LANGUAGE NoRebindableSyntax #-}
{-# OPTIONS_GHC -fno-warn-missing-import-lists #-}
{-# OPTIONS_GHC -w #-}
module Paths_vesting (
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
version = Version [1,0,0,0] []

getDataFileName :: FilePath -> IO FilePath
getDataFileName name = do
  dir <- getDataDir
  return (dir `joinFileName` name)

getBinDir, getLibDir, getDynLibDir, getDataDir, getLibexecDir, getSysconfDir :: IO FilePath



bindir, libdir, dynlibdir, datadir, libexecdir, sysconfdir :: FilePath
bindir     = "/home/ubuntu/.cabal/bin"
libdir     = "/home/ubuntu/.cabal/lib/x86_64-linux-ghc-8.10.7/vesting-1.0.0.0-inplace-vesting-sc"
dynlibdir  = "/home/ubuntu/.cabal/lib/x86_64-linux-ghc-8.10.7"
datadir    = "/home/ubuntu/.cabal/share/x86_64-linux-ghc-8.10.7/vesting-1.0.0.0"
libexecdir = "/home/ubuntu/.cabal/libexec/x86_64-linux-ghc-8.10.7/vesting-1.0.0.0"
sysconfdir = "/home/ubuntu/.cabal/etc"

getBinDir     = catchIO (getEnv "vesting_bindir")     (\_ -> return bindir)
getLibDir     = catchIO (getEnv "vesting_libdir")     (\_ -> return libdir)
getDynLibDir  = catchIO (getEnv "vesting_dynlibdir")  (\_ -> return dynlibdir)
getDataDir    = catchIO (getEnv "vesting_datadir")    (\_ -> return datadir)
getLibexecDir = catchIO (getEnv "vesting_libexecdir") (\_ -> return libexecdir)
getSysconfDir = catchIO (getEnv "vesting_sysconfdir") (\_ -> return sysconfdir)




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
