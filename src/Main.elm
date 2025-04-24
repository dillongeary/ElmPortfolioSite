module Main exposing (..)

import Browser exposing (document)
import Html exposing (Html, div, text, h1)
import Html.Attributes exposing (style)
import Browser.Dom exposing (getViewport, Viewport)
import Platform.Cmd exposing (none)
import Task exposing (perform)
import Time exposing (every)

import HtmlComponents exposing (flexRow, flexCol, timeLine, timeLineBox, projectBox)
import Types exposing (Msg(..), Model, ProjectStatus(..), Skills(..))
import ColorScheme exposing (getColor, Color(..))
import Paragraphs exposing (ampereDesc)


-- MAIN


main = document
    { init = init
    , update = update
    , view = (viewToDocument view)
    , subscriptions = subscriptions
    }


-- DOCUMENT


type alias DocumentType =
    { title : String
    , body : List (Html Msg)
    }

viewToDocument : (Model -> Html Msg) -> Model -> DocumentType
viewToDocument v m = { title = "Webpage", body = [ v m ] }


-- MODEL


init : () -> (Model, Cmd Msg)
init _ =
    (
    { viewport = Nothing
    , darkmode = True
    , positions = Nothing
    }
    , none
    )


-- UPDATE


update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
    case msg of
        GotViewport viewport -> ({model | viewport = Just viewport}, none)
        GetUpdate -> (model, perform GotViewport getViewport)


-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions _ = every 50 (\_ -> GetUpdate)


-- VIEW


column = [ style "flex" "1", style "padding" "10rem 5rem", style "box-sizing" "border-box" ]
contentBox = style "minHeight" "calc(100vh - 20rem)"


getSceneHeight : Maybe Viewport -> String
getSceneHeight maybeViewport =
    case maybeViewport of
        Just viewport -> String.fromFloat (viewport.scene.height)
        Nothing -> "Error"

getViewportY : Maybe Viewport -> String
getViewportY maybeViewport =
    case maybeViewport of
        Just viewport -> String.fromFloat (viewport.viewport.y)
        Nothing -> "Error"


view : Model -> Html Msg
view model =
  flexRow [ style "justify-content" "center", style "min-height" "100vh", style "padding" "0 10rem", style "color" (getColor Text), style "background-color" (getColor Background) ]
    [ flexCol (column ++ [style "align-items" "flex-end", style "height" "100vh", style "justify-content" "center", style "position" "sticky", style "top" "0"])
      [ h1 [] [ text "Title" ]
      , div [] [ text (getSceneHeight model.viewport) ]
      , div [] [ text (getViewportY model.viewport) ]
      ]
    , flexCol (column ++ [style "align-items" "flex-start", style "gap" "10rem"])
      [ div [contentBox]
        [ h1 [] [ text "Career" ]
        , timeLine
          [ timeLineBox
              False
              "Web Developer"
              "Ampere Analysis"
              "2024 - Current"
              [ WebDevelopment, React, Django]
              ampereDesc
          , timeLineBox
              True
              "Web Developer"
              "Ampere Analysis"
              "2024 - Current"
              [ WebDevelopment, React, Django]
              ampereDesc
          ]
        ]
      , div [contentBox]
        [ h1 [] [ text "Projects" ]
        , timeLine
          [ projectBox
              "A Block-Based Visual Programming Language"
              Paused
              "2023 - 2024"
              [ ProgrammingLanguages, Haskell, WebDevelopment, Research ]
              "A block-based visual programming language that takes inspiration for syntax and semantics from Haskell and other functional programming languages. This project involved the design of a block-based functional programming language and the development of a web-based IDE created in Blockly, to create a tool which aids the teaching of functional languages in education."
          ]
        ]
      , div [contentBox]
        [ h1 [] [ text "Education" ]
        , div [] lorem
        ]
      ]
    ]

lorem : List (Html Msg)
lorem = [ div [] [ text "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Praesent vel lorem ornare, iaculis mauris ut, vestibulum nunc. Orci varius natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Donec odio nunc, venenatis at lectus eu, placerat sagittis est. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Quisque sit amet sem eget erat bibendum ullamcorper. Sed gravida lacinia nunc a hendrerit. Fusce nec imperdiet purus, eget iaculis neque. Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas. Proin volutpat suscipit iaculis." ]
    , div [] [ text "Duis id ultricies urna, id venenatis turpis. Praesent feugiat, felis non vestibulum tempor, erat metus sodales velit, ac sollicitudin enim lectus rutrum lorem. Curabitur a lorem mauris. Nunc condimentum sodales ex. Fusce tincidunt massa nisl, hendrerit placerat lacus pellentesque a. Proin imperdiet vitae turpis vel mattis. Nulla fringilla nisl tortor, vitae dignissim erat mollis vel. Vestibulum condimentum ligula quis rutrum vehicula. Quisque maximus facilisis neque. Sed viverra odio elit, ac accumsan magna condimentum vitae. Integer vitae turpis eget leo ornare laoreet." ]
    ]
