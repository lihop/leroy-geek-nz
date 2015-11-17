import Html exposing (..)
import Html.Attributes exposing (..)

port title : String
port title =
  "Leroy Hopson"


main =
  div []
    [ splash
    ]


(=>) = (,)


-- SPLASH

splash : Html
splash =
  div [ id "splash" ]
    [ css "https://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap.min.css"
    , css "https://maxcdn.bootstrapcdn.com/font-awesome/4.4.0/css/font-awesome.min.css"
    , div [ class "container" ]
        [ div [ class "col-md-8 col-md-offset-1", style <| (size 100 5) ]
            [ text "Leroy Hopson" ]
        , details "envelope" "mailto:anything@leroy.geek.nz" "<anything>@leroy.geek.nz"
        , details "key" "https://pgp.mit.edu/pks/lookup?op=vindex&search=0x4D05A4F6CB4E7DEE" "0x4d05a4f6cb4e7dee"
        , details "github" "https://github.com/lihop" "lihop"
        ]
    ]


details : String -> String -> String -> Html
details iconName link displayText =
    div [ class "col-md-8 col-md-offset-1", style (size 15 5) ]
        [ i [ class <| "fa fa-" ++ iconName, style [ "padding" => "5px" ]] []
        , a [ href link ] [ text displayText ]
        ]


css : String -> Html
css path =
  node "link" [ rel "stylesheet", href path ] []


size : Int -> Int -> List (String, String)
size height padding =
    [ "font-size" => (toString height ++ "px")
    , "padding" => (toString padding ++ "px 0")
    ]
