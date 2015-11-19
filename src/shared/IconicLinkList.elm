module IconicLinkList where

import Effects exposing (Effects, map, batch, Never)
import Helper exposing ((=>))
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)

import IconicLink


-- MODEL

type alias Model =
    { iconicLinkList : List (Int, IconicLink.Model)
    }


init : List IconicLink.Model -> (Model, Effects Action)
init iconicLinks =
    let
        len =
            List.length iconicLinks
        iconicLinkList =
            List.map2 (,) [0..len] iconicLinks
    in
        ( Model iconicLinkList
        , Effects.none
        )


makeIconicLink : String -> String -> String -> Int -> IconicLink.Model
makeIconicLink iconName link displayedText size =
    fst <| IconicLink.init iconName link displayedText size


-- UPDATE

type Action
    = SubMsg Int IconicLink.Action


update : Action -> Model -> (Model, Effects Action)
update message model =
    case message of
        SubMsg msgId msg ->
            let
                subUpdate ((id, iconicLink) as entry) =
                    if id == msgId then
                        let
                            (newIconicLink, fx) = IconicLink.update msg iconicLink
                        in
                            ( (id, newIconicLink)
                            , map (SubMsg id) fx
                            )
                    else
                        (entry, Effects.none)

                (newIconicLinkList, fxList) =
                    model.iconicLinkList
                        |> List.map subUpdate
                        |> List.unzip
            in
                ( { model | iconicLinkList <- newIconicLinkList }
                , batch fxList
                )


-- VIEW

view : Signal.Address Action -> Model -> Html
view address model =
    div []
        [ div [ class "container" ]
            (List.map (elementView address) model.iconicLinkList)
        ]


elementView : Signal.Address Action -> (Int, IconicLink.Model) -> Html
elementView address (id, model) =
    div [ class "col-md-8 col-md-offset-1" ]
        [ IconicLink.view (Signal.forwardTo address (SubMsg id)) model
        ]
