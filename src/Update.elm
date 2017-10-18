module Update exposing (update)

import Messages exposing (..)
import Model exposing (..)


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        UpdateInput searchInput ->
            ( { model | searchInput = searchInput }, Cmd.none )

        SetPatients (Err e) ->
            let
                x =
                    Debug.log "x" e
            in
                ( model, Cmd.none )

        SetPatients (Ok patients) ->
            ( { model | patients = patients }, Cmd.none )

        _ ->
            ( model, Cmd.none )
