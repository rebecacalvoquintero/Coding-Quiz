module View exposing (view)

import Html exposing (..)
import Html.Attributes exposing (..)
import Model exposing (..)
import Messages exposing (..)
import Date.Extra exposing (toFormattedString)
import Html.Events exposing (..)
import Date.Extra


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
                [ th []
                    [ span [] [ text "Last name" ]
                    , button [ onClick (SetSorting (Asc LastName)) ] [ text "Asc" ]
                    , button [ onClick (SetSorting (Desc LastName)) ] [ text "Desc" ]
                    ]
                , th []
                    [ span [] [ text "First name" ]
                    , button [ onClick (SetSorting (Asc FirstName)) ] [ text "Asc" ]
                    , button [ onClick (SetSorting (Desc FirstName)) ] [ text "Desc" ]
                    ]
                , th []
                    [ span [] [ text "Date of Birth" ]
                    , button [ onClick (SetSorting (Asc Dob)) ] [ text "Asc" ]
                    , button [ onClick (SetSorting (Desc Dob)) ] [ text "Desc" ]
                    ]
                ]
            ]
        , tbody []
            (List.map viewPatient <|
                List.sortWith (patientsComparator model.sorting) <|
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


patientsComparator : Sorting -> Patient -> Patient -> Order
patientsComparator sorting patient1 patient2 =
    case sorting of
        None ->
            EQ

        Asc FirstName ->
            compare patient1.firstName patient2.firstName

        Desc FirstName ->
            compare patient2.firstName patient1.firstName

        Asc LastName ->
            compare patient1.lastName patient2.lastName

        Desc LastName ->
            compare patient2.lastName patient1.lastName

        Asc Dob ->
            Date.Extra.compare patient1.dob patient2.dob

        Desc Dob ->
            Date.Extra.compare patient2.dob patient1.dob


viewPatient : Patient -> Html Msg
viewPatient patient =
    tr []
        [ td [] [ text patient.lastName ]
        , td [] [ text patient.firstName ]
        , td [] [ text (toFormattedString "d MMMM, y" patient.dob) ]
        ]
