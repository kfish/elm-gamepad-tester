module View.RawData exposing (view)

import Model exposing (Model)
import Msg exposing (Msg(..))
import Html exposing (Html, div)
import Material.List as List


view : Model -> Html Msg
view model =
    div [] []
