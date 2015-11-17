module AwesomeIcon where
{-| This module introduces an icon which has a tipping animation.
It is intended to be used with the font awesome icon library.
Therefore, the icon name should correspond to the the name
of an icon in the font awesome library sans the "fa-" prefix.
-}

import Easing exposing (ease, easeOutBounce, float)
import Effects exposing (Effects)
import Helper exposing ((=>), css)
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onMouseOver)
import Time exposing (Time, second)


-- MODEL

type alias Model =
    { iconName : String
    , size : Int
    , angle : Float
    , animationState : AnimationState
    }


type alias AnimationState =
    Maybe { prevClockTime : Time, elapsedTime : Time }


init : String -> Int -> (Model, Effects Action)
init iconName size =
    ( { iconName = iconName
      , size = size
      , angle = 90
      , animationState = Nothing
      }
    , Effects.none
    )


rotateStep = 45
duration = second


-- UPDATE

type Action
    = Animate
    | Tick Time


update : Action -> Model -> (Model, Effects Action)
update msg model =
    case msg of
        Animate ->
            case model.animationState of
                Nothing ->
                    ( model, Effects.tick Tick)

                Just _ ->
                    ( model, Effects.none )

        Tick clockTime ->
            let
                newElapsedTime =
                    case model.animationState of
                        Nothing ->
                            0

                        Just { elapsedTime, prevClockTime } ->
                            elapsedTime + ( clockTime - prevClockTime )
            in
                if newElapsedTime > duration then
                    ( { iconName = model.iconName
                      , size = model.size
                      , angle = model.angle + rotateStep
                      , animationState = Nothing
                      }
                    , Effects.none
                    )
                else
                    ( { iconName = model.iconName
                      , size = model.size
                      , angle = model.angle
                      , animationState = Just
                          { elapsedTime = newElapsedTime
                          , prevClockTime = clockTime
                          }
                      }
                    , Effects.tick Tick
                    )


-- VIEW

toOffset : AnimationState -> Float
toOffset animationState =
    case animationState of
        Nothing ->
            0

        Just { elapsedTime } ->
            ease easeOutBounce float 0 rotateStep duration elapsedTime


view : Signal.Address Action -> Model -> Html
view address model =
    let
        fontawesome =
            css "https://maxcdn.bootstrapcdn.com/font-awesome/4.4.0/css/font-awesome.min.css"
        angle =
            model.angle + toOffset model.animationState
        iconStyle =
            style
                [ "transform" => ("rotate(" ++ (toString angle) ++ "deg)")
                , "font-size" => ((toString model.size) ++ "px")
                ]
    in
       span []
           [ fontawesome
           , i [ onMouseOver address Animate, class <| "fa fa-" ++ model.iconName, iconStyle ] []
           ]
