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