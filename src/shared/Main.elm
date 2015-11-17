import Effects exposing (Never)
import StartApp
import Task

import IconicLink exposing (init, update, view)


app =
    StartApp.start
        { init = init "github" "https://github.com/lihop" "lihop" 200
        , update = update
        , view = view
        , inputs = []
        }


main =
    app.html


port tasks : Signal (Task.Task Never ())
port tasks =
    app.tasks
