module View.RawData exposing (view)

import Model exposing (Model)
import Msg exposing (Msg(..))
import Html exposing (Html, div, text)
import Material.List as List


view : Model -> Html Msg
view model =
    div []
        [ text (toString model.gamepads) ]
