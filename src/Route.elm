module Route exposing (..)

import Navigation
import UrlParser exposing (parsePath, oneOf, map, top, s, (</>), string)

home : String
home = "elm-gamepad-tester"

type Route
    = Home
    | RawData
    | Legend


type alias Model =
    Maybe Route


pathParser : UrlParser.Parser (Route -> a) a
pathParser =
    oneOf
        [ map Home    (s home)
        , map RawData (s home </> s "data")
        , map Legend  (s home </> s "legend")
        ]


init : Maybe Route -> List (Maybe Route)
init location =
    case location of
        Nothing ->
            [ Just Home ]

        something ->
            [ something ]


urlFor : Route -> String
urlFor loc = "/" ++ home ++
    case loc of
        Home ->
            "/"

        RawData ->
            "/data"

        Legend ->
            "/legend"

locFor : Navigation.Location -> Maybe Route
locFor path =
    parsePath pathParser path
