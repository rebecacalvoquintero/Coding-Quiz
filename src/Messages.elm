module Messages exposing (..)

import Model exposing (..)
import Http


type Msg
    = UpdateInput
    | NextPage
    | PreviousPage
    | SetPatients (Result Http.Error (List Patient))
