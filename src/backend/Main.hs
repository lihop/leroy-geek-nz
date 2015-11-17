{-# LANGUAGE OverloadedStrings #-}

import Network.Wai.Middleware.RequestLogger
import Web.Scotty

main = scotty 3000 $ do
    middleware logStdoutDev

    get "/" $ file "static/home.html"
