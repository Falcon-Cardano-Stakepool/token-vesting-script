{-# LANGUAGE CPP #-}
{-# LANGUAGE NoRebindableSyntax #-}
{-# OPTIONS_GHC -fno-warn-missing-import-lists #-}
{-# OPTIONS_GHC -w #-}
module Paths_primitive (
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
version = Version [0,7,2,0] []

getDataFileName :: FilePath -> IO FilePath
getDataFileName name = do
  dir <- getDataDir
  return (dir `joinFileName` name)

getBinDir, getLibDir, getDynLibDir, getDataDir, getLibexecDir, getSysconfDir :: IO FilePath



bindir, libdir, dynlibdir, datadir, libexecdir, sysconfdir :: FilePath
bindir     = "/home/ubuntu/.cabal/store/ghc-8.10.7/primitive-0.7.2.0-1664deadfd2ab124dfa5776d0a1252e5927fee8c27422b64f6502efcb9113807/bin"
libdir     = "/home/ubuntu/.cabal/store/ghc-8.10.7/primitive-0.7.2.0-1664deadfd2ab124dfa5776d0a1252e5927fee8c27422b64f6502efcb9113807/lib"
dynlibdir  = "/home/ubuntu/.cabal/store/ghc-8.10.7/primitive-0.7.2.0-1664deadfd2ab124dfa5776d0a1252e5927fee8c27422b64f6502efcb9113807/lib"
datadir    = "/home/ubuntu/.cabal/store/ghc-8.10.7/primitive-0.7.2.0-1664deadfd2ab124dfa5776d0a1252e5927fee8c27422b64f6502efcb9113807/share"
libexecdir = "/home/ubuntu/.cabal/store/ghc-8.10.7/primitive-0.7.2.0-1664deadfd2ab124dfa5776d0a1252e5927fee8c27422b64f6502efcb9113807/libexec"
sysconfdir = "/home/ubuntu/.cabal/store/ghc-8.10.7/primitive-0.7.2.0-1664deadfd2ab124dfa5776d0a1252e5927fee8c27422b64f6502efcb9113807/etc"

getBinDir     = catchIO (getEnv "primitive_bindir")     (\_ -> return bindir)
getLibDir     = catchIO (getEnv "primitive_libdir")     (\_ -> return libdir)
getDynLibDir  = catchIO (getEnv "primitive_dynlibdir")  (\_ -> return dynlibdir)
getDataDir    = catchIO (getEnv "primitive_datadir")    (\_ -> return datadir)
getLibexecDir = catchIO (getEnv "primitive_libexecdir") (\_ -> return libexecdir)
getSysconfDir = catchIO (getEnv "primitive_sysconfdir") (\_ -> return sysconfdir)




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
