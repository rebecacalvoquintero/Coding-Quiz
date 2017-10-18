module View exposing (view)

import Html exposing (..)
import Html.Attributes exposing (..)
import Model exposing (..)
import Messages exposing (..)
import Date.Extra exposing (toFormattedString)


view : Model -> Html Msg
view model =
    section []
        [ span [] [ text "search" ]
        , input [] []
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
            (List.map
                viewPatient
                model.patients
            )
        ]


viewPatient : Patient -> Html Msg
viewPatient patient =
    tr []
        [ td [] [ text patient.lastName ]
        , td [] [ text patient.firstName ]
        , td [] [ text (toFormattedString ("d MMMM, y") (patient.dob)) ]
        ]
