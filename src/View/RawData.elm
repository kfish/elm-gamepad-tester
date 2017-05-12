module View.RawData exposing (view)

import Model exposing (Model)
import Msg exposing (Msg(..))
import Html exposing (Html, div, text)
import Material.Color as Color
import Material.Grid as Grid exposing (grid, size, cell, Device(..))
import Material.Elevation as Elevation
import Material.Options as Options exposing (css)

import Gamepad exposing (Gamepad)

view : Model -> Html Msg
view model =
    grid [
            Color.background <| Color.color Color.Grey Color.S900
         ] <|
        case model.gamepads of
            [] -> [ noGamepadsCell ]
            _  -> List.map rawGamepadCell model.gamepads

textCell : String -> Grid.Cell msg
textCell str =
    cell
        [ size All 12
        , Elevation.e2
        , Options.css "align-items" "center"
        , Options.cs "mdl-grid"
        -- , Color.text <| Color.color Color.Green Color.S500
        , Color.text <| Color.color Color.Grey Color.S200
        ]
        [
            text str
        ]

noGamepadsCell : Grid.Cell msg
noGamepadsCell = textCell
    "No gamepads detected. Press a button to activate."

rawGamepadCell : Gamepad -> Grid.Cell msg
rawGamepadCell gamepad = textCell (toString gamepad)
