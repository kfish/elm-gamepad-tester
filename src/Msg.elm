module Msg exposing (Msg(..))

import Material
import Material.Snackbar as Snackbar
import Navigation


type Msg
    = Mdl (Material.Msg Msg)
    | Snackbar (Snackbar.Msg (Maybe Msg))
    | NavigateTo Navigation.Location
    | NewUrl String
    | Toggle (List Int)
    | SelectMail String
    | ViewSourceClick String
