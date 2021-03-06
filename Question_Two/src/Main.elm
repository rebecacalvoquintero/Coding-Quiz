module Main exposing (..)

import Html
import Messages exposing (..)
import Model exposing (..)
import Update exposing (update)
import View exposing (view)
import ApiGet


subscriptions : a -> Sub msg
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


init : ( Model, Cmd Msg )
init =
    ( initialModel, ApiGet.getInitialData )


initialModel : Model
initialModel =
    { searchInput = ""
    , patients = []
    , pageSize = 10
    , currentPage = 0
    , sorting = None
    , focusedPatientId = Nothing
    , username = ""
    , password = ""
    , token = ""
    , loginError = Nothing
    , loggedIn = False
    }
