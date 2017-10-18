module ApiGet exposing (..)

import Http exposing (get)
import Messages exposing (..)
import Model exposing (..)
import Date
import Json.Decode as Decode
import Json.Decode.Pipeline exposing (required, optional, decode, hardcoded)
import Json.Decode.Extra exposing (date)


getInitialData : Cmd Msg
getInitialData =
    let
        url =
            "https://api.interview.healthforge.io:443/api/patient"

        request =
            Http.get url initialDataDecoder
    in
        Http.send SetPatients request


type alias Patients =
    List Patient


initialDataDecoder : Decode.Decoder (List Patient)
initialDataDecoder =
    Decode.at [ "content" ] (Decode.list patientDecoder)


patientDecoder : Decode.Decoder Patient
patientDecoder =
    decode Patient
        |> required "lastName" Decode.string
        |> required "firstName" Decode.string
        |> required "dateOfBirth" date
