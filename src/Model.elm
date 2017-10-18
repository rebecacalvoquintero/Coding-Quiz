module Model exposing (..)

import Date


type alias Model =
    { searchInput : String
    , patients : List Patient
    }


type alias Patient =
    { lastName : String
    , firstName : String
    , dob : Date.Date
    }
