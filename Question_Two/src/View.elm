module View exposing (view)

import Html exposing (..)
import Html.Attributes exposing (..)
import Model exposing (..)
import Messages exposing (..)
import Date.Extra exposing (toFormattedString)
import Html.Events exposing (..)
import Date.Extra
import ViewPatient


view : Model -> Html Msg
view model =
    if True then
        viewLogin
    else
        viewMain model


viewLogin : Html Msg
viewLogin =
    div
        [ class "firstPage" ]
        [ header [ class "white f1 mb5 tc tracked pa4" ] [ text "healthForge" ]
        , section []
            [ Html.form [ class "login center mt4 pa2 ", method "POST" ]
                [ input [ class "inputButton darkgray bg-white-40 w-100 h3 pa1 bn mb3 mw6 db pl2 center", id "email", type_ "email", placeholder "email", name "email" ] []
                , input [ class "inputButton darkgray bg-white-40 w-100 h3 pa1 bn mb3 mw6 db pl2 center", id "password", name "password", type_ "password", placeholder "password" ] []
                , button [ class "submitButton f4 w-100 h3 pa1 bn mb2 mw6 db center", type_ "submit", name "submit" ] [ text "Login" ]
                ]
            ]
        ]


viewMain : Model -> Html Msg
viewMain model =
    section []
        [ viewNavBar model

        -- case model.focusedPatientId of
        --   Nothing ->
        , (case model.focusedPatientId of
            Nothing ->
                div
                    []
                    [ input
                        [ onInput UpdateInput
                        , value model.searchInput
                        , class "searchBar center db w-75 w-50-m w-33-l f3 pa2 ma4"
                        , placeholder "start your search"
                        ]
                        []
                    , viewTable model
                    ]

            Just id ->
                ViewPatient.view model id
          )
        ]


viewNavBar : Model -> Html Msg
viewNavBar model =
    div [ class "navBar w-100 h4 tc f3 white" ]
        [ img [ src "../assets/healthforge_logo.png", class "logo tc" ] []
        , h1 [ class "title ma1 pa2" ] [ text "healthForge" ]
        ]


viewTable : Model -> Html Msg
viewTable model =
    let
        filteredPatients =
            List.filter (filterBySearch model.searchInput) model.patients

        patientsOnPage =
            List.drop (model.pageSize * model.currentPage) filteredPatients
                |> List.take model.pageSize

        morePatientsAfterPage =
            ((model.currentPage + 1) * model.pageSize) < List.length filteredPatients

        pageCount =
            ceiling (toFloat (List.length filteredPatients) / toFloat model.pageSize)

        pages =
            List.range 1 pageCount
    in
        div []
            [ table [ class "center" ]
                [ thead [ class "tableBox" ]
                    [ tr []
                        [ th [ class "tableHeader f4 br5 pa3" ]
                            [ span [ class "borderbox fl ma2 tc" ] [ text "Last name" ]
                            , button [ onClick (SetSorting (Asc LastName)) ] [ img [ class "image tc", src "https://iconmonstr.com/wp-content/g/gd/makefg.php?i=../assets/preview/2014/png/iconmonstr-sort-13.png&r=0&g=0&b=0" ] [] ]
                            , button [ onClick (SetSorting (Desc LastName)) ] [ img [ class "image tc", src "https://iconmonstr.com/wp-content/g/gd/makefg.php?i=../assets/preview/2014/png/iconmonstr-sort-16.png&r=0&g=0&b=0" ] [] ]
                            ]
                        , th [ class " tableHeader f4 br5 pa3" ]
                            [ span [ class "borderbox fl ma2 tc" ] [ text "First name" ]
                            , button [ onClick (SetSorting (Asc FirstName)) ] [ img [ class "image tc", src "https://iconmonstr.com/wp-content/g/gd/makefg.php?i=../assets/preview/2014/png/iconmonstr-sort-13.png&r=0&g=0&b=0" ] [] ]
                            , button [ onClick (SetSorting (Desc FirstName)) ] [ img [ class "image tc", src "https://iconmonstr.com/wp-content/g/gd/makefg.php?i=../assets/preview/2014/png/iconmonstr-sort-16.png&r=0&g=0&b=0" ] [] ]
                            ]
                        , th [ class " tableHeader f4 br5 pa3" ]
                            [ span [ class "borderbox fl ma2 tc" ] [ text "Date of Birth" ]
                            , button [ src "", onClick (SetSorting (Asc Dob)) ] [ img [ class "image", src "https://iconmonstr.com/wp-content/g/gd/makefg.php?i=../assets/preview/2014/png/iconmonstr-sort-18.png&r=0&g=0&b=0" ] [] ]
                            , button [ onClick (SetSorting (Desc Dob)) ] [ img [ class "image", src "https://iconmonstr.com/wp-content/g/gd/makefg.php?i=../assets/preview/2014/png/iconmonstr-sort-20.png&r=0&g=0&b=0" ] [] ]
                            ]
                        ]
                    ]
                , tbody [ class "tableBody ma2 f5 ma2 br5 pa2" ]
                    (List.map viewPatientRow <|
                        List.sortWith (patientsComparator model.sorting) <|
                            patientsOnPage
                    )
                ]
            , div [ class "footerContainerParent" ]
                [ div [ class "center footerContainer" ]
                    (let
                        previous =
                            button
                                [ onClick PreviousPage
                                , disabled (model.currentPage == 0)
                                , class
                                    "previous shadow-hover button previous f3 pa2 ma2 fl"
                                ]
                                [ text "previous" ]

                        next =
                            button
                                [ onClick NextPage
                                , disabled (not morePatientsAfterPage)
                                , class "next shadow-hover button next f3 pa2 ma2 fr"
                                ]
                                [ text "next" ]

                        pageDropdown =
                            select [ class "page-dropdown f3 pa2", onInput SetPage ]
                                (List.map
                                    (\n ->
                                        option
                                            [ selected (n - 1 == model.currentPage)
                                            , value (toString n)
                                            ]
                                            [ text (toString n) ]
                                    )
                                    pages
                                )
                     in
                        [ previous
                        , pageDropdown
                        , next
                        ]
                    )
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


viewPatientRow : Patient -> Html Msg
viewPatientRow patient =
    tr [ onClick (SetFocusedPatient patient), class "shadow-hover" ]
        [ td [] [ text patient.lastName ]
        , td [] [ text patient.firstName ]
        , td [] [ text (toFormattedString "d MMMM, y" patient.dob) ]
        ]
