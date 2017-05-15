module Update exposing (update)

import Model exposing (Model)
import Msg exposing (Msg(..))
import Material
import Material.Snackbar as Snackbar
import Navigation
import Route exposing (Route)
import Dict
import Ports
import Task

import Gamepad

update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Mdl msg_ ->
            Material.update Mdl msg_ model

        Snackbar msg_ ->
            let
                ( snackbar, snackCmd ) =
                    Snackbar.update msg_ model.snackbar
            in
                { model | snackbar = snackbar } ! [ Cmd.map Snackbar snackCmd ]

        NavigateTo location ->
            location
                |> Route.locFor
                |> urlUpdate model
        NewUrl url ->
            model ! [ Navigation.newUrl url ]

        Toggle index ->
            let
                toggles =
                    case (Dict.get index model.toggles) of
                        Just v ->
                            Dict.insert index (not v) model.toggles

                        Nothing ->
                            Dict.insert index True model.toggles
            in
                { model | toggles = toggles } ! []

        ViewSourceClick url ->
            model ! [ Ports.windowOpen url ]

        GamepadMsg gamepads ->
            -- In an actual game you would update your player
            -- position here, rather than just returning the
            -- raw gamepad data.
            ( { model | gamepads = gamepads }, Gamepad.gamepads GamepadMsg )


urlUpdate : Model -> Maybe Route -> ( Model, Cmd Msg )
urlUpdate model route =
    { model | history = route :: model.history } ! []
