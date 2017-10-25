module Auth exposing (..)

import Http exposing (get)
import Messages exposing (..)
import Model exposing (..)
import Date
import Json.Decode as Decode
import Json.Decode.Pipeline exposing (required, optional, decode, hardcoded)
import Json.Decode.Extra exposing (date)
import Json.Encode as Encode exposing (..)


login : String -> String -> Cmd Msg
login username password =
    let
        url =
            "https://auth.healthforge.io/auth/realms/interview/protocol/openid-connect/token"

        json =
            Http.jsonBody encode

        request =
            Http.post url json postReplyDecoder
    in
        Http.send RecieveLoginReply request



-- userEncoder : Model -> Encode.Value
-- userEncoder model =
--     Encode.object
--         [ ( "username", Encode.string model.username )
--         , ( "password", Encode.string model.password )
--         ]
--
--
-- authUser : Model -> String -> Http.Request String
-- authUser model apiUrl =
--     let
--         body =
--             model
--                 |> userEncoder
--                 |> Http.jsonBody
--     in
--         Http.post apiUrl body tokenDecoder
--
--
-- authUserCmd : Model -> String -> Cmd Msg
-- authUserCmd model apiUrl =
--     Http.send GetTokenCompleted (authUser model apiUrl)
--
--
-- getTokenCompleted : Model -> Result Http.Error String -> ( Model, Cmd Msg )
-- getTokenCompleted model result =
--     case result of
--         Ok newToken ->
--             ( { model | token = newToken, password = "", errorMsg = "" } |> Debug.log "got new token", Cmd.none )
--
--         Err error ->
--             ( { model | errorMsg = (toString error) }, Cmd.none )
