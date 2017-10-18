module Main exposing (..)

import Html
import Messages exposing (..)
import Model exposing (..)
import Update exposing (update)
import View exposing (view)
import ApiGet


subscriptions model =
    Sub.none


main : Program Never Model Msg
main =
    Html.program
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }


init =
    ( initialModel, ApiGet.getInitialData )


initialModel : Model
initialModel =
    { searchInput = ""
    , patients = []
    }
