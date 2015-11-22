import Helper exposing (..)
import Html exposing (..)
import Html.Attributes exposing (..)

main =
    div [ style
            [ "max-width" => "507px"
            , "max-height" => "576px"
            , "margin" => "auto"
            , "position" => "absolute"
            , "top" => "0"
            , "bottom" => "0"
            , "left" => "0"
            , "right" => "0"
        ]   ]
        [ bootstrap
        , img [ src "/svg/slab404.svg", style [ ]] []
        , div [ style [ "position" => "absolute", "left" => "100px", "top" => "50px" ]]
            [ h1 []
                [ div [ style engraved ]
                    [ text "Pedestal 404"
                    , div [ style <| [ "font-size" => "0.5em" , "font-weight" => "normal" ]]
                        [ text "Page Not Found" ]
                    ]
                ]
            ]
        , div [ style [ "position" => "absolute", "left" => "110px", "top" => "215px" ]]
            [ h1 [ style <| [ "font-size" => "1.3em" ] ++ engraved ]
                [ text "My name is Ozymandius, king of kings:"
                , br [][]
                , text "Look on my works, ye Mighty, and despair!"
                ]
            , p [ style <|
                    [ "text-align" => "right", "font-style" => "italic" ] ++ engraved ]
                [ text "Percy Bysshe Shelley" ]
            ]
        ]


engraved : List (String, String)
engraved =
    [ "color" => "#8a8a8a"
    , "text-shadow" => "0px 1px 0px rgba(0,0,0,1)"
    ]
