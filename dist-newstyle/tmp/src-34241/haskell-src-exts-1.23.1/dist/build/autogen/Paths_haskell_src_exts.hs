{-# LANGUAGE CPP #-}
{-# LANGUAGE NoRebindableSyntax #-}
{-# OPTIONS_GHC -fno-warn-missing-import-lists #-}
{-# OPTIONS_GHC -w #-}
module Paths_haskell_src_exts (
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
version = Version [1,23,1] []

getDataFileName :: FilePath -> IO FilePath
getDataFileName name = do
  dir <- getDataDir
  return (dir `joinFileName` name)

getBinDir, getLibDir, getDynLibDir, getDataDir, getLibexecDir, getSysconfDir :: IO FilePath



bindir, libdir, dynlibdir, datadir, libexecdir, sysconfdir :: FilePath
bindir     = "/home/ubuntu/.cabal/store/ghc-8.10.7/haskell-src-exts-1.23.1-65eee2ddfaebbd1121addc65c06b522ee52c8b8a8bf3615d41aa70f22d39fafd/bin"
libdir     = "/home/ubuntu/.cabal/store/ghc-8.10.7/haskell-src-exts-1.23.1-65eee2ddfaebbd1121addc65c06b522ee52c8b8a8bf3615d41aa70f22d39fafd/lib"
dynlibdir  = "/home/ubuntu/.cabal/store/ghc-8.10.7/haskell-src-exts-1.23.1-65eee2ddfaebbd1121addc65c06b522ee52c8b8a8bf3615d41aa70f22d39fafd/lib"
datadir    = "/home/ubuntu/.cabal/store/ghc-8.10.7/haskell-src-exts-1.23.1-65eee2ddfaebbd1121addc65c06b522ee52c8b8a8bf3615d41aa70f22d39fafd/share"
libexecdir = "/home/ubuntu/.cabal/store/ghc-8.10.7/haskell-src-exts-1.23.1-65eee2ddfaebbd1121addc65c06b522ee52c8b8a8bf3615d41aa70f22d39fafd/libexec"
sysconfdir = "/home/ubuntu/.cabal/store/ghc-8.10.7/haskell-src-exts-1.23.1-65eee2ddfaebbd1121addc65c06b522ee52c8b8a8bf3615d41aa70f22d39fafd/etc"

getBinDir     = catchIO (getEnv "haskell_src_exts_bindir")     (\_ -> return bindir)
getLibDir     = catchIO (getEnv "haskell_src_exts_libdir")     (\_ -> return libdir)
getDynLibDir  = catchIO (getEnv "haskell_src_exts_dynlibdir")  (\_ -> return dynlibdir)
getDataDir    = catchIO (getEnv "haskell_src_exts_datadir")    (\_ -> return datadir)
getLibexecDir = catchIO (getEnv "haskell_src_exts_libexecdir") (\_ -> return libexecdir)
getSysconfDir = catchIO (getEnv "haskell_src_exts_sysconfdir") (\_ -> return sysconfdir)




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
