module Update exposing (update)

import Messages exposing (..)
import Model exposing (..)


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        UpdateInput searchInput ->
            ( { model | searchInput = searchInput, currentPage = 0 }, Cmd.none )

        SetSorting sorting ->
            ( { model | sorting = sorting }, Cmd.none )

        PreviousPage ->
            ( { model | currentPage = model.currentPage - 1 }, Cmd.none )

        NextPage ->
            ( { model | currentPage = model.currentPage + 1 }, Cmd.none )

        SetPage page ->
            ( { model
                | currentPage =
                    (String.toInt page
                        |> Result.withDefault model.currentPage
                        |> (\n -> n - 1)
                    )
              }
            , Cmd.none
            )

        SetPatients (Err e) ->
            let
                x =
                    Debug.log "x" e
            in
                ( model, Cmd.none )

        SetPatients (Ok patients) ->
            ( { model | patients = patients }, Cmd.none )

        SetFocusedPatient patient ->
            ( { model | focusedPatientId = Just patient }, Cmd.none )

        UnfocusPatient ->
            ( { model | focusedPatientId = Nothing }, Cmd.none )
