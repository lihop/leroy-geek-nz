import Graphics.Element as E exposing (..)
import Html exposing (..)
import Html.Attributes exposing (..)
import Text
import Window

port title : String
port title =
  "Leroy Hopson"


main =
  div []
    [ splash
    ]


(=>) = (,)


-- SPLASH

splash =
  div [ id "splash" ]
    [ div [ size 100 16 ] [ text "Leroy Hopson" ]
    ]


size height padding =
  style
    [ "font-size" => (toString height ++ "px")
    , "padding" => (toString padding ++ "px 0")
    ]
