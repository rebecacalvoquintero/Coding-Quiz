module Messages exposing (..)

import Model exposing (..)
import Http


type Msg
    = UpdateInput String
    | SetSorting Sorting
    | NextPage
    | PreviousPage
    | SetPage String
    | SetPatients (Result Http.Error (List Patient))
    | SetFocusedPatient Patient
    | UnfocusPatient
    | UpdateUsername String
    | UpdatePassword String
    | Login
    | HandleAuthReply (Result Http.Error String)
