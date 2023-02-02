{-# LANGUAGE CPP #-}
{-# LANGUAGE NoRebindableSyntax #-}
{-# OPTIONS_GHC -fno-warn-missing-import-lists #-}
{-# OPTIONS_GHC -w #-}
module Paths_prettyprinter (
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
version = Version [1,7,0] []

getDataFileName :: FilePath -> IO FilePath
getDataFileName name = do
  dir <- getDataDir
  return (dir `joinFileName` name)

getBinDir, getLibDir, getDynLibDir, getDataDir, getLibexecDir, getSysconfDir :: IO FilePath



bindir, libdir, dynlibdir, datadir, libexecdir, sysconfdir :: FilePath
bindir     = "/home/ubuntu/.cabal/store/ghc-8.10.7/prettyprinter-1.7.0-6a8e43a2ce5307f1c3aa4e4ef63b5a3d9e4d9fbe59944b23759283daa2bf001f/bin"
libdir     = "/home/ubuntu/.cabal/store/ghc-8.10.7/prettyprinter-1.7.0-6a8e43a2ce5307f1c3aa4e4ef63b5a3d9e4d9fbe59944b23759283daa2bf001f/lib"
dynlibdir  = "/home/ubuntu/.cabal/store/ghc-8.10.7/prettyprinter-1.7.0-6a8e43a2ce5307f1c3aa4e4ef63b5a3d9e4d9fbe59944b23759283daa2bf001f/lib"
datadir    = "/home/ubuntu/.cabal/store/ghc-8.10.7/prettyprinter-1.7.0-6a8e43a2ce5307f1c3aa4e4ef63b5a3d9e4d9fbe59944b23759283daa2bf001f/share"
libexecdir = "/home/ubuntu/.cabal/store/ghc-8.10.7/prettyprinter-1.7.0-6a8e43a2ce5307f1c3aa4e4ef63b5a3d9e4d9fbe59944b23759283daa2bf001f/libexec"
sysconfdir = "/home/ubuntu/.cabal/store/ghc-8.10.7/prettyprinter-1.7.0-6a8e43a2ce5307f1c3aa4e4ef63b5a3d9e4d9fbe59944b23759283daa2bf001f/etc"

getBinDir     = catchIO (getEnv "prettyprinter_bindir")     (\_ -> return bindir)
getLibDir     = catchIO (getEnv "prettyprinter_libdir")     (\_ -> return libdir)
getDynLibDir  = catchIO (getEnv "prettyprinter_dynlibdir")  (\_ -> return dynlibdir)
getDataDir    = catchIO (getEnv "prettyprinter_datadir")    (\_ -> return datadir)
getLibexecDir = catchIO (getEnv "prettyprinter_libexecdir") (\_ -> return libexecdir)
getSysconfDir = catchIO (getEnv "prettyprinter_sysconfdir") (\_ -> return sysconfdir)




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
