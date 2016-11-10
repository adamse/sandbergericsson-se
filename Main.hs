module Main where

import Development.Shake
import Development.Shake.Command
import Development.Shake.FilePath
import Development.Shake.Util
import Lucid

import Site

dest :: FilePath
dest = "_site"

main :: IO ()
main = shakeArgs shakeOptions{shakeFiles="_build"} $ do
  let files = map (dest </>) ["index.html","style.css"]
  want files

  phony "clean" $ do
    removeFilesAfter "_build" ["//*"]
    removeFilesAfter dest ["//*"]

  phony "publish" $ do
    need files
    cmd "scp" "-r" dest "ett.ethnoll.se:www/adam"

  dest </> "style.css" %> \out -> do
    copyFile' "style.css" out

  dest </> "index.html" %> \out -> do
    liftIO (renderToFile out site)
