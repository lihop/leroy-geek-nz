import Effects exposing (Effects, Never)
import Helper exposing ((=>), css, bootstrap)
import Html exposing (..)
import Html.Attributes exposing (..)
import IconicLinkList exposing (makeIconicLink)
import StartApp
import Task


-- MODEL

type alias Model =
    { iconicLinkList : IconicLinkList.Model }


init : (Model, Effects Action)
init =
    let
        iconicLinks =
            [ makeIconicLink "envelope" "mailto:anything@leroy.geek.nz" "<anything>@leroy.geek.nz" 25
            , makeIconicLink "key" "https://pgp.mit.edu/pks/lookup?op=vindex&search=0x4D05A4F6CB4E7DEE" "0x4d05a4f6cb4e7dee" 25
            , makeIconicLink "github" "https://github.com/lihop" "lihop" 25
            ]
        (iconicLinkList, iconicLinkListFx) =
            IconicLinkList.init iconicLinks
    in
        ( Model iconicLinkList
        , Effects.none
        )


--UPDATE

type Action
    = IconicLinkList IconicLinkList.Action


update : Action -> Model -> (Model, Effects Action)
update action model =
    case action of
        IconicLinkList act ->
            let
                (iconicLinkList, fx) = IconicLinkList.update act model.iconicLinkList
            in
                (Model iconicLinkList
                , Effects.map IconicLinkList fx
                )


-- VIEW

(=>) = (,)


view : Signal.Address Action -> Model -> Html
view address model =
    div []
      [ bootstrap
      , Helper.forkMeOnGitHub
      , div [ class "container" ]
          [ div [ class "col-md-8 col-md-offset-1", style <| (size 100 5) ]
              [ text "Leroy Hopson" ]
          , IconicLinkList.view (Signal.forwardTo address IconicLinkList) model.iconicLinkList
          ]
      ]


size : Int -> Int -> List (String, String)
size height padding =
    [ "font-size" => (toString height ++ "px")
    , "padding" => (toString padding ++ "px 0")
    ]


-- START APP

app =
    StartApp.start
        { init = init
        , update = update
        , view = view
        , inputs = []
        }


main = app.html


port title : String
port title =
  "Leroy Hopson"


port tasks : Signal (Task.Task Never ())
port tasks =
    app.tasks
