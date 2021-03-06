module ViewPatient exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Messages exposing (..)
import Model exposing (..)
import Date.Extra exposing (toFormattedString)


view : Model -> Patient -> Html Msg
view model patient =
    div [ class "center pl6 pt4 f4" ]
        [ div [] [ span [] [ text "First Name: " ], span [] [ text patient.firstName ] ]
        , div [] [ span [] [ text "Last Name: " ], span [] [ text patient.lastName ] ]
        , div [] [ span [] [ text "Date of Birth: " ], span [] [ text (toFormattedString "d MMMM, y" patient.dob) ] ]
        , div [] [ span [] [ text "Gender: " ], span [] [ text patient.gender ] ]
        , div [] [ span [] [ text "Title: " ], span [] [ text patient.title ] ]
        , div [] [ span [] [ text "Telecoms: " ], viewTelecoms patient ]
        , button [ onClick UnfocusPatient, class "shadow-hover button f3 pa2 ma2" ] [ text "back" ]
        ]


viewTelecoms : Patient -> Html Msg
viewTelecoms patient =
    let
        viewTelecom i t =
            div [ class "ml2" ]
                [ div [] [ text ((toString (i + 1)) ++ ".") ]
                , div [ class "ml2" ] [ span [] [ text "Usage: " ], span [] [ text t.usage ] ]
                , div [ class "ml2" ] [ span [] [ text "Value: " ], span [] [ text t.value ] ]
                ]
    in
        div [] (List.indexedMap viewTelecom patient.telecoms)
