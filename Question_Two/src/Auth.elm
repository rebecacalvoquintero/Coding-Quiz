module Auth exposing (..)

import Http
import Messages exposing (..)
import Json.Decode as Decode
import Exts.Http


login : String -> String -> Cmd Msg
login username password =
    let
        url =
            "https://auth.healthforge.io/auth/realms/interview/protocol/openid-connect/token"

        -- body =
        --     Debug.log "json" <| Http.jsonBody <| encodeAuthData { username = username, password = password }
        body =
            Exts.Http.formBody
                [ ( "username", username )
                , ( "password", password )
                , ( "grant_type", "password" )
                , ( "client_id", "interview" )
                ]

        request =
            Http.post url body postReplyDecoder
    in
        Http.send HandleAuthReply request


postReplyDecoder : Decode.Decoder String
postReplyDecoder =
    Decode.field "access_token" Decode.string
