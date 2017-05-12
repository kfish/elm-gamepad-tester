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
    }


initialModel : Maybe Route -> Model
initialModel location =
    { mdl = Material.model
    , snackbar = Snackbar.model
    , history = Route.init location
    , toggles = Dict.empty
    }


init : Navigation.Location -> ( Model, Cmd Msg )
init location =
    (location |> Route.locFor |> initialModel) ! [ Material.init Mdl ]
