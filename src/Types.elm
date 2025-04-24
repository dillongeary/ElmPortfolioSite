module Types exposing (..)

import Browser.Dom exposing (Viewport)


type alias Model =
    { viewport : Maybe Viewport
    , darkmode : Bool
    , positions : Maybe (Int, Int, Int)
    }

type Msg
  = GotViewport Viewport
  | GetUpdate
