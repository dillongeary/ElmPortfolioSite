module Types exposing (..)

import Browser.Dom exposing (Element, Error, Viewport)
import Html exposing (Html)


type ContentShorthand
    = Text_ String
    | Html_ (List (Html Msg))


type alias Model =
    { viewport : Maybe Int
    , darkmode : Bool
    , positions : Maybe ( Int, Int )
    }


type PageSection
    = Career
    | Projects
    | Education


type Msg
    = GotViewport Viewport
    | GotPositions (Result Error (List Element))
    | GetPositionUpdate
    | GetViewportUpdate
    | GoTo PageSection
    | ChangeLightDarkMode
    | NoOp


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
    | HTML
    | CSS
    | ProjectManagement
    | AppDevelopment
    | Kotlin
    | UI
    | Database
    | API
