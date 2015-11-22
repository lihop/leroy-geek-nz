{-# LANGUAGE OverloadedStrings #-}

import Network.Wai.Middleware.RequestLogger
import Network.Wai.Middleware.Static
import Web.Scotty

main = scotty 3000 $ do
    middleware logStdoutDev
    middleware $ staticPolicy (noDots >-> addBase "assets")

    get "/" $ file "static/home.html"
    notFound $ file "static/404.html"
