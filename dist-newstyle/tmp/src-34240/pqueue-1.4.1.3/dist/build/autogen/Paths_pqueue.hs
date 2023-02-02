{-# LANGUAGE CPP #-}
{-# LANGUAGE NoRebindableSyntax #-}
{-# OPTIONS_GHC -fno-warn-missing-import-lists #-}
{-# OPTIONS_GHC -w #-}
module Paths_pqueue (
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
version = Version [1,4,1,3] []

getDataFileName :: FilePath -> IO FilePath
getDataFileName name = do
  dir <- getDataDir
  return (dir `joinFileName` name)

getBinDir, getLibDir, getDynLibDir, getDataDir, getLibexecDir, getSysconfDir :: IO FilePath



bindir, libdir, dynlibdir, datadir, libexecdir, sysconfdir :: FilePath
bindir     = "/home/ubuntu/.cabal/store/ghc-8.10.7/pqueue-1.4.1.3-393efc53b6535ef7ab27106dfad6361cf2e289f9b0868e84bfbfc92fa353d6e0/bin"
libdir     = "/home/ubuntu/.cabal/store/ghc-8.10.7/pqueue-1.4.1.3-393efc53b6535ef7ab27106dfad6361cf2e289f9b0868e84bfbfc92fa353d6e0/lib"
dynlibdir  = "/home/ubuntu/.cabal/store/ghc-8.10.7/pqueue-1.4.1.3-393efc53b6535ef7ab27106dfad6361cf2e289f9b0868e84bfbfc92fa353d6e0/lib"
datadir    = "/home/ubuntu/.cabal/store/ghc-8.10.7/pqueue-1.4.1.3-393efc53b6535ef7ab27106dfad6361cf2e289f9b0868e84bfbfc92fa353d6e0/share"
libexecdir = "/home/ubuntu/.cabal/store/ghc-8.10.7/pqueue-1.4.1.3-393efc53b6535ef7ab27106dfad6361cf2e289f9b0868e84bfbfc92fa353d6e0/libexec"
sysconfdir = "/home/ubuntu/.cabal/store/ghc-8.10.7/pqueue-1.4.1.3-393efc53b6535ef7ab27106dfad6361cf2e289f9b0868e84bfbfc92fa353d6e0/etc"

getBinDir     = catchIO (getEnv "pqueue_bindir")     (\_ -> return bindir)
getLibDir     = catchIO (getEnv "pqueue_libdir")     (\_ -> return libdir)
getDynLibDir  = catchIO (getEnv "pqueue_dynlibdir")  (\_ -> return dynlibdir)
getDataDir    = catchIO (getEnv "pqueue_datadir")    (\_ -> return datadir)
getLibexecDir = catchIO (getEnv "pqueue_libexecdir") (\_ -> return libexecdir)
getSysconfDir = catchIO (getEnv "pqueue_sysconfdir") (\_ -> return sysconfdir)




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
