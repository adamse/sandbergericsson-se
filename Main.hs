{-# LANGUAGE OverloadedStrings #-}
-- |

module Main where

import Lucid
import Lucid.Base

import Data.Monoid

main :: IO ()
main = do let fp = "index.html"
          renderToFile fp site

site :: Html ()
site =
  doctypehtml_
    (do sitehead
        body_ (div_ [class_ "container-fluid main"]
                    (h1_ "Adam Sandberg Eriksson" <>
                     mconcat boxes <>
                     toHtmlRaw analytics)))
  where boxes = [addr,online,currently]


addr :: Html ()
addr =
  box_ (do p_ (a_ [href_ "mailto:adam@sandbergericsson.se"] "adam@sandbergericsson.se")
           p_ (address_ ("Doktor Wigardhs gata 2" <> br_ [] <>
                         "413 23 Göteborg" <> br_ [] <>
                         "Sweden")))

online :: Html ()
online =
  box_ (do h2_ "On the internet"
           ul_ (do li_ (a_ [href_ "https://github.com/adamse"] "github.com/adamse")
                   li_ (a_ [href_ "https://www.facebook.com/adamsericsson"]
                           "www.facebook.com/adamsericsson")
                   li_ (a_ [href_ "http://stackoverflow.com/users/204218/adamse"]
                           "stackoverflow.com/users/204218/adamse")
                   li_ (a_ [href_ "http://se.linkedin.com/in/adamsandbergericsson"]
                           "linkedin.com/in/adamsandbergericsson")
                   li_ ("Also see my " <>
                        a_ [href_ "https://github.com/adamse/cv/raw/master/cv_en.pdf"] "CV")))

currently :: Html ()
currently =
  box_ (do h2_ "Currently"
           p_ ("I'm studying the master programme " <>
               a_ [href_ "http://www.chalmers.se/en/education/programmes/masters-info/Pages/Computer-Science-algorithms-languages-and-logic.aspx"]
                  "Computer science--Algorithms, Languages and Logic" <>
               ".")
           p_ ("I'm organising the 2015 edition of the " <>
               a_ [href_ "http://gbgstartuphack.com/"] "Gothenburg Startup Hack" <>
               "."))

box_ :: Term arg res => arg -> res
box_ = termWith "div" [makeAttribute "class" "col-xs-12 col-sm-6 col-md-4"]

sitehead :: Html ()
sitehead =
  head_ (do meta_ [charset_ "utf-8"]
            meta_ [name_ "viewport"
                  ,content_ "width=device-width, initial-scale=1"]
            link_ [rel_ "icon",type_ "image/png",href_ "/icon.png"]
            link_ [rel_ "stylesheet"
                  ,href_ "//maxcdn.bootstrapcdn.com/bootstrap/3.3.0/css/bootstrap.min.css"]
            link_ [rel_ "stylesheet"
                  ,href_ "//fonts.googleapis.com/css?family=Anonymous+Pro:400,700"]
            link_ [rel_ "stylesheet",href_ "style.css"]
            title_ "Adam Sandberg Eriksson")


analytics :: String
analytics = "<script>(function(i,s,o,g,r,a,m){i['GoogleAnalyticsObject']=r;i[r]=i[r]||function(){(i[r].q=i[r].q||[]).push(arguments)},i[r].l=1*new Date();a=s.createElement(o),m=s.getElementsByTagName(o)[0];a.async=1;a.src=g;m.parentNode.insertBefore(a,m)})(window,document,'script','//www.google-analytics.com/analytics.js','ga');ga('create', 'UA-60251317-2', 'auto');ga('send', 'pageview');</script>"
