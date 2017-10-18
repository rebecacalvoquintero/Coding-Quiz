module Messages exposing (..)

import Model exposing (..)
import Http


type Msg
    = UpdateInput String
    | NextPage
    | PreviousPage
    | SetPatients (Result Http.Error (List Patient))
