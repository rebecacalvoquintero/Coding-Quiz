module Messages exposing (..)

import Model exposing (..)
import Http


type Msg
    = UpdateInput String
    | SetSorting Sorting
    | NextPage
    | PreviousPage
    | SetPatients (Result Http.Error (List Patient))
