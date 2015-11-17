import Effects exposing (Never)
import AwesomeIcon exposing (init, update, view)
import StartApp
import Task


app =
    StartApp.start
        { init = init "cog" 200
        , update = update
        , view = view
        , inputs = []
        }


main =
    app.html


port tasks : Signal (Task.Task Never ())
port tasks =
    app.tasks
