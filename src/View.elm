module View exposing (view)

import Html exposing (..)
import Html.Attributes exposing (..)
import Model exposing (..)
import Messages exposing (..)
import Date.Extra exposing (toFormattedString)
import Html.Events exposing (..)


view : Model -> Html Msg
view model =
    section []
        [ span [] [ text "search" ]
        , input [ onInput UpdateInput, value model.searchInput ] []
        , viewTable model
        ]


viewTable : Model -> Html Msg
viewTable model =
    table []
        [ thead []
            [ tr []
                [ th [] [ text "Last name" ]
                , th [] [ text "First name" ]
                , th [] [ text "Date of Birth" ]
                ]
            ]
        , tbody []
            (List.map viewPatient <|
                List.filter (filterBySearch model.searchInput)
                    model.patients
            )
        , tfoot []
            [ button [] [ text "previous" ]
            , button [] [ text "next" ]
            ]
        ]


filterBySearch : String -> Patient -> Bool
filterBySearch searchInput patient =
    let
        ciContains string =
            String.contains (String.toLower searchInput) (String.toLower string)
    in
        ciContains patient.firstName || ciContains patient.lastName || ciContains (toFormattedString "d MMMM, y" patient.dob)


viewPatient : Patient -> Html Msg
viewPatient patient =
    tr []
        [ td [] [ text patient.lastName ]
        , td [] [ text patient.firstName ]
        , td [] [ text (toFormattedString "d MMMM, y" patient.dob) ]
        ]
