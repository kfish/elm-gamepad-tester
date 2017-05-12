module View exposing (view)

import Html exposing (Html, text, div, span, form)
import Html.Attributes exposing (href, src)
import Model exposing (Model)
import Msg exposing (Msg(..))
import Material.Layout as Layout
import Material.Snackbar as Snackbar
import Material.Icon as Icon
import Material.Color as Color
import Material.Menu as Menu
import Material.Dialog as Dialog
import Material.Button as Button
import Material.Options as Options exposing (css, cs, when)
import Route exposing (Route(..))
import View.Home
import View.Legend
import View.RawData
import Material.Scheme


styles : String
styles =
    """
   .demo-options .mdl-checkbox__box-outline {
      border-color: rgba(255, 255, 255, 0.89);
    }

   .mdl-layout__drawer {
      border: none !important;
   }

   .mdl-layout__drawer .mdl-navigation__link:hover {
      background-color: #00BCD4 !important;
      color: #37474F !important;
    }
   """


view : Model -> Html Msg
view model =
    Material.Scheme.top <|
        Layout.render Mdl
                model.mdl
                [ Layout.fixedHeader
                , Layout.fixedDrawer
                , Options.css "display" "flex !important"
                , Options.css "flex-direction" "row"
                , Options.css "align-items" "center"
                ]
                { header = [ viewHeader model ]
                , drawer = [ drawerHeader model, viewDrawer model ]
                , tabs = ( [], [] )
                , main =
                    [ viewBody model
                    , Snackbar.view model.snackbar |> Html.map Snackbar
                    ]
                }


viewHeader : Model -> Html Msg
viewHeader model =
    Layout.row
        [ Color.background <| Color.black
        , Color.text <| Color.color Color.Green Color.S500
        ]
        [ Layout.title [] [ text "elm-gamepad Tester" ]
        , Layout.spacer
        , Layout.navigation []
            []
        ]


viewSource : Model -> Html Msg
viewSource model =
    Button.render Mdl
        [ 5, 6, 6, 7 ]
        model.mdl
        [ css "position" "fixed"
        , css "display" "block"
        , css "left" "100"
        , css "bottom" "0"
        , css "margin-left" "80px"
        , css "margin-bottom" "40px"
        , css "z-index" "900"
        , Color.background <| Color.color Color.Green Color.S500
        , Color.text Color.white
        , Button.ripple
        , Button.colored
        , Button.raised
        , Options.onClick (ViewSourceClick "https://github.com/kfish/elm-gamepad-tester")
        ]
        [ text "View Source" ]


type alias MenuItem =
    { text : String
    , iconName : String
    , route : Maybe Route
    }


menuItems : List MenuItem
menuItems =
    [ { text = "Gamepads", iconName = "gamepad", route = Just Home }
    , { text = "Data", iconName = "code", route = Just RawData }
    , { text = "Legend", iconName = "map", route = Just Legend }
    ]


viewDrawerMenuItem : Model -> MenuItem -> Html Msg
viewDrawerMenuItem model menuItem =
    let
        isCurrentLocation =
            case model.history of
                currentLocation :: _ ->
                    currentLocation == menuItem.route

                _ ->
                    False

        onClickCmd =
            case ( isCurrentLocation, menuItem.route ) of
                ( False, Just route ) ->
                    route |> Route.urlFor |> NewUrl |> Options.onClick

                _ ->
                    Options.nop
    in
        Layout.link
            [ onClickCmd
            , when isCurrentLocation (Color.background <| Color.color Color.BlueGrey Color.S900)
            , Options.css "color" "rgba(0, 255, 0, 0.56)"
            , Options.css "font-weight" "500"
            ]
            [ Icon.view menuItem.iconName
                [ Color.text <| Color.color Color.Green Color.S500
                , Options.css "margin-right" "32px"
                ]
            , text menuItem.text
            ]


viewDrawer : Model -> Html Msg
viewDrawer model =
    Layout.navigation
        [ Color.background <| Color.black
        , Color.text <| Color.white
        , Options.css "flex-grow" "1"
        ]
    <|
        (List.map (viewDrawerMenuItem model) menuItems)
            ++ [ Layout.spacer
               , viewSource model
               ]


drawerHeader : Model -> Html Msg
drawerHeader model =
    Options.styled Html.header
        [ css "display" "flex"
        , css "box-sizing" "border-box"
        , css "justify-content" "flex-end"
        , css "padding" "16px"
        , css "height" "151px"
        , css "flex-direction" "column"
        , cs "demo-header"
        , Color.background <| Color.black
        , Color.text <| Color.color Color.Green Color.S900
        ]
        [ Options.styled Html.img
            [ Options.attribute <| src "images/xbox-1602822_640.jpg"
            , css "width" "100%"
            , css "height" "100%"
            -- , css "border-radius" "24px"
            ]
            []
        ]


viewBody : Model -> Html Msg
viewBody model =
    case model.history |> List.head |> Maybe.withDefault Nothing of
        Just Route.Home ->
            View.Home.view model

        Just Route.RawData ->
            View.RawData.view model

        Just Route.Legend ->
            View.Legend.view model

        Nothing ->
            text "404"

