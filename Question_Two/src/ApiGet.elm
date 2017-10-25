module ApiGet exposing (..)

import Http exposing (get)
import Messages exposing (..)
import Model exposing (..)
import Json.Decode as Decode
import Json.Decode.Pipeline exposing (required, optional, decode, hardcoded)
import Json.Decode.Extra exposing (date)


getInitialData : Cmd Msg
getInitialData =
    let
        url =
            "https://api.interview.healthforge.io:443/api/patient?size=1000"

        request =
            Http.get url initialDataDecoder
    in
        Http.send SetPatients request


initialDataDecoder : Decode.Decoder (List Patient)
initialDataDecoder =
    Decode.at [ "content" ] (Decode.list patientDecoder)


patientDecoder : Decode.Decoder Patient
patientDecoder =
    decode Patient
        |> required "lastName" Decode.string
        |> required "firstName" Decode.string
        |> required "dateOfBirth" date
        |> required "gender" Decode.string
        |> required "prefix" Decode.string
        |> required "telecoms" (Decode.list telecomDecoder)


telecomDecoder : Decode.Decoder Telecom
telecomDecoder =
    decode Telecom
        |> required "usage" Decode.string
        |> required "value" Decode.string
