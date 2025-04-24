module Types exposing (..)

import Browser.Dom exposing (Error, Viewport, Element)
import Html exposing (Html)


type ContentShorthand
  = Text_ String
  | Html_ (Html Msg)


type alias Model =
    { viewport : Maybe Int
    , darkmode : Bool
    , positions : Maybe (Int, Int)
    }


type CurrentSection
  = Career
  | Projects
  | Education


type Msg
  = GotViewport Viewport
  | GotPositions (Result Error (List Element))
  | GetUpdate


type ProjectStatus
  = Paused
  | Ongoing
  | Complete


type Skills
  = ProgrammingLanguages
  | Haskell
  | WebDevelopment
  | Research
  | React
  | JavaScript
  | Python
  | Django
  | Java
  | AppDevelopment
  | Kotlin
  | UI
  | Database
  | API