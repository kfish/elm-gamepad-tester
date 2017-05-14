module View.Home exposing (view)

import Model exposing (Model)
import Msg exposing (Msg(..))
import Html exposing (Html, div, text)
import Html.Attributes exposing (style)
import Material.Color as Color
import Material.Grid as Grid exposing (Cell, grid, size, cell, Device(..))
import Material.Elevation as Elevation
import Material.Options as Options exposing (css)
import Material.Table as Table
import Material.Typography as Typography

import Gamepad exposing (..)

view : Model -> Html Msg
view model =
    div [
            style [ ("background-color", "rgba(33, 33, 33, 1.0)") ]
        ] <|
        case model.gamepads of
            [] -> [ noGamepadsCell ]
            _  -> [ grid [] (List.map gamepadCell model.gamepads) ]

cell6 : Html msg -> Cell msg
cell6 contents =
    cell
        [ size All 6, Elevation.e2
        -- , Options.css "align-items" "center"
        -- , Options.cs "mdl-grid"
        ]
        [
            contents
        ]

noGamepadsCell : Html msg
noGamepadsCell =
        Table.table []
            [ Table.thead []
            [ Table.tr []
                [ Table.th
                    [ Options.attribute <| Html.Attributes.colspan 2
                    , Color.background <| Color.color Color.Grey Color.S500
                    , Color.text <| Color.color Color.BlueGrey Color.S900
                    ]
                    [ Html.text "No gamepads detected. Press a button to activate." ]
                ]
            ]
            , Table.tbody []
                [ blankRow "buttonA"
                , blankRow "buttonB"
                , blankRow "buttonX"
                , blankRow "buttonY"

                , blankRow "leftTrigger"
                , blankRow "leftBumper "
                , blankRow  "leftStick"
                , blankRow "leftStick.button"

                , blankRow "rightTrigger"
                , blankRow "rightBumper"
                , blankRow  "rightStick"
                , blankRow "rightStick.button"

                , blankRow "dPadUp"
                , blankRow "dPadDown"
                , blankRow "dPadLeft"
                , blankRow "dPadRight"

                , blankRow "buttonBack"
                , blankRow "buttonStart"
                , blankRow "buttonLogo"

                ]
            ]

gamepadCell : Gamepad -> Cell msg
gamepadCell gamepad = case gamepad of
    StandardGamepad standardGamepad ->
    cell6 <|
        Table.table []
            [ Table.thead []
            [ Table.tr []
                [ Table.th
                    [ Options.attribute <| Html.Attributes.colspan 2
                    , Color.background <| Color.color Color.Grey Color.S300
                    , Color.text <| Color.color Color.BlueGrey Color.S900
                    ]
                    [ Html.text standardGamepad.id]
                ]
            ]
            , Table.tbody []
                [ buttonRow "buttonA" standardGamepad.buttonA
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

                , buttonRow "buttonBack" standardGamepad.buttonBack
                , buttonRow "buttonStart" standardGamepad.buttonStart
                , buttonRow "buttonLogo" standardGamepad.buttonLogo

                ]
            ]

    RawGamepad rg ->
        cell6 (text <| toString gamepad)

fieldRow : String -> Float -> List (Html msg) -> Html msg
fieldRow name value td =
    Table.tr []
            [ Table.td (properties value) [ Html.text name ]
            , Table.td (css "text-align" "left" :: properties value) td
            ]

blankRow : String -> Html msg
blankRow name = fieldRow name 0 []

buttonRow : String -> Button -> Html msg
buttonRow name button =
    let
        td = [ Html.text (toString button.value) ]
    in
        fieldRow name button.value td

stickRow : String -> Stick -> Html msg
stickRow name { x, y } =
    let
        magnitude = sqrt (x*x + y*y)

        td = [ Html.text ("(x: " ++ toString x ++ ", y: " ++ toString y ++ ")") ]
    in
        fieldRow name magnitude td

properties : Float -> List (Options.Property c m)
properties value =
    let
        typography = [ Typography.title ]

        shade = valueToShade value
        bg =
            if value > 0.01 then
                [ Color.background <| Color.color Color.Yellow shade ]
            else
                [ Color.background <| Color.color Color.Grey Color.S500 ]
        fg =
            if value < 0.11 then
                [ Color.background <| Color.color Color.Grey Color.S500
                , Color.text <| Color.color Color.Grey Color.S900
                ]
            else
                [ Color.text <| Color.color Color.BlueGrey Color.S900 ]
    in
        typography ++ bg ++ fg

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
