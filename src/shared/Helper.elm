module Helper where

import Html exposing (..) 
import Html.Attributes exposing (..)


(=>) = (,)


css : String -> Html
css path =
    node "link" [ rel "stylesheet", href path ] []
