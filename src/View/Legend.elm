module View.Legend exposing (view)

import Model exposing (Model)
import Msg exposing (Msg(..))
import Html exposing (Html, img)
import Html.Attributes exposing (src)
import Material.Grid as Grid exposing (grid, size, cell, Device(..))
import Material.Elevation as Elevation
import Material.Options as Options exposing (css)

import Gamepad exposing (Gamepad)

view : Model -> Html Msg
view model =
    grid []
        [ cell
            [ size All 12
            , Elevation.e2
            , Options.css "align-items" "center"
            , Options.cs "mdl-grid"
            ]
            [
                img [ src "https://raw.githubusercontent.com/kfish/elm-gamepad/master/images/StandardGamepad.jpg" ] []
            ]
        ]
