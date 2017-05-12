module Model exposing (Model, init, initialModel)

import Msg exposing (Msg(Mdl), Msg(GamepadMsg))
import Material
import Material.Snackbar as Snackbar
import Route exposing (Route)
import Dict exposing (Dict)
import Navigation

import Gamepad

type alias Model =
    { mdl : Material.Model
    , snackbar : Snackbar.Model (Maybe Msg)
    , history : List (Maybe Route)
    , toggles : Dict (List Int) Bool
    , gamepads : List Gamepad.Gamepad
    }


initialModel : Maybe Route -> Model
initialModel location =
    { mdl = Material.model
    , snackbar = Snackbar.model
    , history = Route.init location
    , toggles = Dict.empty
    , gamepads = []
    }


init : Navigation.Location -> ( Model, Cmd Msg )
init location =
    (location |> Route.locFor |> initialModel) !
    [ Material.init Mdl
    , Gamepad.gamepads GamepadMsg
    ]
