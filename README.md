# elm-gamepad Tester

This is a companion app for testing
[elm-gamepad](https://github.com/kfish/elm-gamepad).
It shows the values of buttons and sticks of connected controllers.

* [Live demo](http://kfish.github.io/elm-gamepad-tester/)

## Build locally

To view it locally, clone this repository and run elm-reactor:

```
$ git clone https://github.com/kfish/elm-gamepad-tester.git
$ cd elm-gamepad
$ elm-package install
# elm-make src/Main.elm --output target/elm.js
```

Then run a web server, such as:

```
$ python -m SimpleHTTPServer
```

and visit http://localhost:8000/

## Installation

This package depends on
[elm-gamepad](https://github.com/kfish/elm-gamepad).
which contains experimental Native code
and is not yet whiteliested for inclusion in the Elm package archive.
To build against elm-gamepad you will need to use an unofficial installer like
[elm-install](https://github.com/gdotdesign/elm-github-install)


## History

This app is inspired by the [HTML5 Gamepad Tester](http://html5gamepad.com/).

The code for this app is derived from the
[elm-mdl Dashboard example](https://github.com/vipentti/elm-mdl-dashboard)
by Ville Penttinen.

## License

MIT Licensed, see LICENSE for more details.
