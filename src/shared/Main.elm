import Effects exposing (Never)
import StartApp
import Task

import IconicLinkList exposing (init, update, view, makeIconicLink)


app =
    let
        iconicLinks =
            [ makeIconicLink "envelope" "mailto:anything@leroy.geek.nz" "<anything>@leroy.geek.nz" 50
            , makeIconicLink "key" "https://pgp.mit.edu/pks/lookup?op=vindex&search=0x4D05A4F6CB4E7DEE" "0x4d05a4f6cb4e7dee" 50
            , makeIconicLink "github" "https://github.com/lihop" "lihop" 50
            ]
    in
        StartApp.start
            { init = init iconicLinks
            , update = update
            , view = view
            , inputs = []
            }


main =
    app.html


port tasks : Signal (Task.Task Never ())
port tasks =
    app.tasks
