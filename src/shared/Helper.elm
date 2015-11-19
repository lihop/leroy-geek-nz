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


forkMeOnGitHub : Html
forkMeOnGitHub =
    a [ href "https://github.com/lihop/leroy-geek-nz" ]
        [ img
            [ style
                [ "position" => "absolute"
                , "top" => "0"
                , "right" => "0"
                , "border" =>  "0"
                ]
            , src "https://camo.githubusercontent.com/a6677b08c955af8400f44c6298f40e7d19cc5b2d/68747470733a2f2f73332e616d617a6f6e6177732e636f6d2f6769746875622f726962626f6e732f666f726b6d655f72696768745f677261795f3664366436642e706e67"
            , alt "Fork me on GitHub"
            , property "data-canonical-src"
                (Json.string "https://s3.amazonaws.com/github/ribbons/forkme_right_gray_6d6d6d.png")
            ] []
        ]
