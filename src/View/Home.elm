module View.Home exposing (view)

import Model exposing (Model)
import Msg exposing (Msg(..))
import Html exposing (Html, div, text)
import Html.Attributes
import Material.Color as Color
import Material.Grid as Grid exposing (grid, size, cell, Device(..))
import Material.Elevation as Elevation
import Material.Options as Options exposing (css)
import Material.Table as Table

import Gamepad exposing (..)

view : Model -> Html Msg
view model =
    div [] <|
        case model.gamepads of
            [] -> [ noGamepadsCell ]
            _  -> List.map rawGamepadCell model.gamepads

textCell : String -> Html msg
textCell str =
    grid
        []
        [ cell
              [ size All 12 , Elevation.e2
              , Options.css "align-items" "center"
              , Options.cs "mdl-grid"
              ]
              [
                  text str
              ]
        ]

noGamepadsCell : Html msg
noGamepadsCell = textCell "No gamepads connected."

rawGamepadCell : Gamepad -> Html msg
rawGamepadCell gamepad = case gamepad of
    StandardGamepad standardGamepad ->
        Table.table []
            [ Table.thead []
            [ Table.tr []
                [ Table.th
                    [ Options.attribute <| Html.Attributes.colspan 2 ]
                    [ Html.text standardGamepad.id]
                ]
            ]
            , Table.tbody []
                [ buttonRow "buttonBack" standardGamepad.buttonBack
                , buttonRow "buttonStart" standardGamepad.buttonStart
                , buttonRow "buttonLogo" standardGamepad.buttonLogo

                , buttonRow "buttonA" standardGamepad.buttonA
                , buttonRow "buttonB" standardGamepad.buttonB
                , buttonRow "buttonX" standardGamepad.buttonX
                , buttonRow "buttonY" standardGamepad.buttonY

                , buttonRow "leftTrigger" standardGamepad.leftTrigger
                , buttonRow "leftBumper " standardGamepad.leftBumper
                , stickRow  "leftStick"   standardGamepad.leftStick

                , buttonRow "rightTrigger" standardGamepad.rightTrigger
                , buttonRow "rightBumper"  standardGamepad.rightBumper
                , stickRow  "rightStick"   standardGamepad.rightStick

                , buttonRow "dPadUp"    standardGamepad.dPadUp
                , buttonRow "dPadDown"  standardGamepad.dPadDown
                , buttonRow "dPadLeft"  standardGamepad.dPadLeft
                , buttonRow "dPadRight" standardGamepad.dPadRight
                ]
            ]

    RawGamepad rg ->
        textCell (toString gamepad)

fieldRow : String -> Html msg -> Html msg
fieldRow name td =
    Table.tr []
            [ Table.td [] [ Html.text name ]
            , td
            ]

buttonRow : String -> Button -> Html msg
buttonRow name button =
    let properties =
            if button.pressed then
                [ Color.background <| Color.color Color.Yellow Color.S300 ]
            else
                []

        td = Table.td
                 properties
                 [ Html.text (toString button) ]
    in
        fieldRow name td

stickRow : String -> Stick -> Html msg
stickRow name stick =
    let properties =
            if stick.button.pressed then
                [ Color.background <| Color.color Color.Yellow Color.S300 ]
            else
                []

        td = Table.td
                 properties
                 [ Html.text (toString stick) ]
    in
        fieldRow name td
