module Model exposing (..)

import Date


type alias Model =
    { searchInput : String
    , patients : List Patient
    , pageSize : Int
    , currentPage : Int
    }


type alias Patient =
    { lastName : String
    , firstName : String
    , dob : Date.Date
    }
