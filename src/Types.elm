module Types exposing (..)

import Browser.Dom exposing (Element, Error, Viewport)
import Http
import JSONDecoder exposing (WebsiteData)


type alias Model =
    { viewport : Maybe Int
    , darkmode : Bool
    , positions : Maybe ( Int, Int )
    , httpResponse : HttpResponse
    }


type HttpResponse
    = Failure
    | Loading
    | Success WebsiteData


type PageSection
    = Career
    | Projects
    | Education


type Msg
    = GotViewport Viewport
    | GotPositions (Result Error (List Element))
    | GotWebsiteData (Result Http.Error WebsiteData)
    | GetPositionUpdate
    | GetViewportUpdate
    | GetWebsiteDataUpdate
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
    | Nothing


decodeSkills : String -> Skills
decodeSkills skill =
    case skill of
        "ProgrammingLanguages" ->
            ProgrammingLanguages

        "Haskell" ->
            Haskell

        "WebDevelopment" ->
            WebDevelopment

        "Research" ->
            Research

        "React" ->
            React

        "JavaScript" ->
            JavaScript

        "Python" ->
            Python

        "Django" ->
            Django

        "Java" ->
            Java

        "HTML" ->
            HTML

        "CSS" ->
            CSS

        "ProjectManagement" ->
            ProjectManagement

        "AppDevelopment" ->
            AppDevelopment

        "Kotlin" ->
            Kotlin

        "UI" ->
            UI

        "Database" ->
            Database

        "API" ->
            API

        _ ->
            Nothing
