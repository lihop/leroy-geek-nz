module IconicLink where
{-| A little widget consisting of an animated icon on the left and a link on
the right. The widget does a neat little trick when hovered over. For example
the icon might tip to the side (i.e. take a bow).
-}

import AwesomeIcon
import Effects exposing (Effects)
import Helper exposing ((=>))
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onMouseOver)


-- MODEL

type alias Model =
    { icon : AwesomeIcon.Model
    , link : String
    , text : String
    , size : Int
    }


init : String -> String -> String -> Int -> (Model, Effects Action)
init iconName link text size =
    let
        (icon, iconFx) = (AwesomeIcon.init iconName size)
    in
        ( Model icon link text size
        , Effects.map Icon iconFx
        )


-- UPDATE

type Action
    = Icon AwesomeIcon.Action
    | Link


update : Action -> Model -> (Model, Effects Action)
update action model =
    case action of
        Icon act ->
            let
                (icon, fx) = AwesomeIcon.update act model.icon
            in
                ( Model icon model.link model.text model.size
                , Effects.map Icon fx
                )

        Link ->
            let
                (icon, fx) = AwesomeIcon.update AwesomeIcon.Animate model.icon
            in
                ( Model icon model.link model.text model.size
                , Effects.map Icon fx
                )


-- VIEW

view : Signal.Address Action -> Model -> Html
view address model =
    div [ style [ "display" => "flex" ]
        , onMouseOver address Link
        ]
        [ AwesomeIcon.view (Signal.forwardTo address Icon) model.icon
        , a [ href model.link
            , style [ "font-size" => ((toString model.size) ++ "px") ]
            ]
            [ text model.text ]
        ]
