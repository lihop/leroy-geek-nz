module Helper where

import Html exposing (..)
import Html.Attributes exposing (..)
import Json.Encode as Json


(=>) = (,)


css : String -> Html
css path =
    node "link"
        [ rel "stylesheet"
        , href path
        ] []

integrousCss : String -> Json.Value -> Json.Value -> Html
integrousCss path integrity crossorigin =
    node "link"
        [ rel "stylesheet"
        , href path
        , property "integrity" integrity
        , property "crossorigin" crossorigin
        ] []


fontawesome : Html
fontawesome =
    css
        "https://maxcdn.bootstrapcdn.com/font-awesome/4.4.0/css/font-awesome.min.css"


bootstrap : Html
bootstrap =
    integrousCss
        "https://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap.min.css"
        (Json.string "sha512-dTfge/zgoMYpP7QbHy4gWMEGsbsdZeCXz7irItjcC3sPUFtf0kuFbDz/ixG7ArTxmDjLXDmezHubeNikyKGVyQ==")
        (Json.string "anonymous")
