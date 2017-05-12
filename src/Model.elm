module Model exposing (Model, init, initialModel)

import Msg exposing (Msg(Mdl))
import Material
import Material.Snackbar as Snackbar
import Route exposing (Route)
import Dict exposing (Dict)
import Navigation


type alias Model =
    { mdl : Material.Model
    , snackbar : Snackbar.Model (Maybe Msg)
    , history : List (Maybe Route)
    , toggles : Dict (List Int) Bool
    , selectedMail : String
    }


initialModel : Maybe Route -> Model
initialModel location =
    { mdl = Material.model
    , snackbar = Snackbar.model
    , history = Route.init location
    , toggles = Dict.empty
    , selectedMail = "elm.mdl@example.0"
    }


init : Navigation.Location -> ( Model, Cmd Msg )
init location =
    (location |> Route.locFor |> initialModel) ! [ Material.init Mdl ]
