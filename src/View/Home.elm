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
import Material.Typography as Typography

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

                , buttonRow "leftTrigger"       standardGamepad.leftTrigger
                , buttonRow "leftBumper "       standardGamepad.leftBumper
                , stickRow  "leftStick"         standardGamepad.leftStick
                , buttonRow "leftStick.button"  standardGamepad.leftStick.button

                , buttonRow "rightTrigger"       standardGamepad.rightTrigger
                , buttonRow "rightBumper"        standardGamepad.rightBumper
                , stickRow  "rightStick"         standardGamepad.rightStick
                , buttonRow "rightStick.button"  standardGamepad.rightStick.button

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
    let shade = valueToShade button.value
        properties = [ Typography.title ] ++
            if button.pressed then
                [ Color.background <| Color.color Color.Yellow shade ]
            else
                []

        td = Table.td
                 properties
                 [ Html.text (toString button.value) ]
    in
        fieldRow name td

stickRow : String -> Stick -> Html msg
stickRow name { x, y } =
    let magnitude = sqrt (x*x + y*y)
        shade = valueToShade magnitude
        properties = [ Typography.title ] ++
            if magnitude > 0.01 then
                [ Color.background <| Color.color Color.Yellow shade ]
            else
                []

        td = Table.td
                 properties
                 [ Html.text ("(x: " ++ toString x ++ ", y: " ++ toString y ++ ")") ]
    in
        fieldRow name td

valueToShade : Float -> Color.Shade
valueToShade value =
    if abs value < 0.1 then
        Color.S50
    else if value < 0.2 then
        Color.S100
    else if value < 0.3 then
        Color.S200
    else if value < 0.4 then
        Color.S300
    else if value < 0.5 then
        Color.S400
    else if value < 0.6 then
        Color.S500
    else if value < 0.7 then
        Color.S600
    else if value < 0.8 then
        Color.S700
    else if value < 0.9 then
        Color.S800
    else
        Color.S900
