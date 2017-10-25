module Model exposing (..)

import Date


type alias Model =
    { searchInput : String
    , patients : List Patient
    , pageSize : Int
    , currentPage : Int
    , sorting : Sorting
    , focusedPatientId : Maybe Patient
    , username : String
    , password : String
    , token : String
    }


type Sorting
    = Asc Column
    | Desc Column
    | None


type Column
    = FirstName
    | LastName
    | Dob


type alias Patient =
    { lastName : String
    , firstName : String
    , dob : Date.Date
    , gender : String
    , title : String
    , telecoms : List Telecom
    }


type alias Telecom =
    { usage : String
    , value : String
    }
