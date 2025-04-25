module Main exposing (..)

import Browser exposing (document)
import Browser.Dom exposing (getViewport, Viewport, getElement, setViewport)

import Html exposing (Html, div, text, h1, a)
import Html.Attributes exposing (style, id, classList)
import Html.Events exposing (onClick)

import Platform.Cmd exposing (none)

import Task exposing (perform, sequence, attempt, succeed, andThen)

import Time exposing (every)

import HtmlComponents exposing (flexRow, flexCol, timeLine, timeLineBox, projectBox)
import Types exposing (Msg(..), Model, ProjectStatus(..), Skills(..), ContentShorthand, PageSection(..))
import ColorScheme exposing (getGetColor, Color(..))
import Paragraphs exposing (ampereDesc, blockellDesc, sotonDesc, activePointsDesc, internshipDesc, kingJohnDesc)


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
        GotViewport viewport -> ({ model | viewport = Just (round viewport.viewport.y) }, none)
        GotPositions result -> case result of
            Ok [eProject, eEducation] -> ({ model | positions = Just (round eProject.element.y, round eEducation.element.y) }, none)
            _ -> (model, none)
        GetUpdate -> ( model
                     , if model.positions == Nothing
                     then attempt GotPositions (sequence [ getElement "HProject", getElement "HEducation" ] )
                     else perform GotViewport getViewport
                     )
        GoTo section -> ( model
                        , case section of
                            Career -> perform (\_ -> NoOp) (setViewport 0 0)
                            Projects -> case model.positions of
                              Nothing -> none
                              Just (i,_) -> perform (\_ -> NoOp) (setViewport 0 (toFloat (i - 181)))
                            Education -> case model.positions of
                              Nothing -> none
                              Just (_,i) -> perform (\_ -> NoOp) (setViewport 0 (toFloat (i - 181)))
                        )
        ChangeLightDarkMode -> ({model | darkmode = not model.darkmode}, none)
        NoOp -> ( model, none )


-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions _ = every 50 (\_ -> GetUpdate)


-- VIEW


getCurrentSection : Model -> PageSection
getCurrentSection model =
  let
    currentYScroll =
      case model.viewport of
        Nothing -> 0
        Just i -> i
    (projectsPosition, educationPosition) =
      case model.positions of
        Nothing -> (100,100)
        Just i -> i
  in
  case ((currentYScroll+381) >= projectsPosition, ((currentYScroll+381) >= educationPosition)) of
    (False, False) -> Career
    (True, False) -> Projects
    (True, True) -> Education
    _ -> Education



view : Model -> Html Msg
view model = let currentSection = getCurrentSection model
                 getColor = getGetColor model
                 column = [ style "flex" "1", style "padding" "10rem 5rem", style "box-sizing" "border-box" ]
                 pageLink = [ style "color" (getColor Overlay), style "text-decoration" "underline", style "cursor" "pointer", style "transition" "font-size 0.5s, color 0.5s, font-weight 0.5s"]
                 activePageLink = [ style "color" (getColor Flamingo), style "cursor" "pointer", style "font-size" "2.5em", style "font-weight" "bold", style "font-style" "italic", style "transition" "font-size 0.5s, color 0.5s, font-weight 0.5s"]
                 contentBox = style "minHeight" "calc(100vh - 20rem)"
  in
  div [style "color" (getColor Text), style "background-color" (getColor Background), style "font-family" "sans-serif"] [
  flexRow [ style "justify-content" "center", style "min-height" "100vh", style "max-width" "1600px", style "margin" "auto"]
    [ flexCol (column ++ [style "align-items" "flex-end", style "height" "100vh", style "justify-content" "center", style "position" "sticky", style "top" "0"])
      [ h1 [ style "font-size" "5rem"] [ text "Dillon Geary" ]
      , a ([ onClick (GoTo Career)
          ] ++ if (currentSection == Career) then activePageLink else pageLink
          ) [text "Career"]
      , a ([ onClick (GoTo Projects)
          ] ++ if (currentSection == Projects) then activePageLink else pageLink
          ) [text "Projects"]
      , a ([ onClick (GoTo Education)
          ] ++ if (currentSection == Education) then activePageLink else pageLink
          ) [text "Education"]
      ]
    , flexCol (column ++ [style "align-items" "flex-start", style "gap" "10rem"])
      [ div [contentBox]
        [ h1 [id "HCareer"] [ text "Career" ]
        , timeLine
          [ timeLineBox
              False
              "Web Developer"
              "Ampere Analysis"
              "2024 - Current"
              [ WebDevelopment, React, Django, UI, Database, API]
              ampereDesc
          , timeLineBox
              True
              "Software Engineer - Intern"
              "University of Southampton"
              "2023"
              [ AppDevelopment, Kotlin, Research, UI]
              internshipDesc
          ]
        ]
      , div [contentBox]
        [ h1 [id "HProject"] [ text "Projects" ]
        , timeLine
          [ projectBox
              "A Block-Based Visual Programming Language"
              Paused
              "2022 - 2024"
              [ ProgrammingLanguages, Haskell, WebDevelopment, Research ]
              blockellDesc
          , projectBox
              "Web-Based Medical Data Dashboard"
              Complete
              "2023"
              [ WebDevelopment, React, UI, API ]
              activePointsDesc
          ]
        ]
      , div [contentBox]
        [ h1 [id "HEducation"] [ text "Education" ]
        , timeLine
          [ timeLineBox
              False
              "University of Southampton"
              "First Class MEng Computer Science"
              "2020 - 2024"
              []
              sotonDesc
          , timeLineBox
              True
              "The King John School and Sixth Form"
              ""
              "2013 - 2020"
              []
              kingJohnDesc
          ]
        ]
      ]
    , div
      [ style "position" "fixed"
      , style "top" "0"
      , style "right" "0"
      , style "margin" "1.5rem 2rem"
      , style "cursor" "pointer"
      , onClick ChangeLightDarkMode
      ]
      [ text (if model.darkmode then "Lightmode" else "Darkmode") ]
    ]
    ]

lorem : List (Html Msg)
lorem = [ div [] [ text "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Praesent vel lorem ornare, iaculis mauris ut, vestibulum nunc. Orci varius natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Donec odio nunc, venenatis at lectus eu, placerat sagittis est. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Quisque sit amet sem eget erat bibendum ullamcorper. Sed gravida lacinia nunc a hendrerit. Fusce nec imperdiet purus, eget iaculis neque. Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas. Proin volutpat suscipit iaculis." ]
    , div [] [ text "Duis id ultricies urna, id venenatis turpis. Praesent feugiat, felis non vestibulum tempor, erat metus sodales velit, ac sollicitudin enim lectus rutrum lorem. Curabitur a lorem mauris. Nunc condimentum sodales ex. Fusce tincidunt massa nisl, hendrerit placerat lacus pellentesque a. Proin imperdiet vitae turpis vel mattis. Nulla fringilla nisl tortor, vitae dignissim erat mollis vel. Vestibulum condimentum ligula quis rutrum vehicula. Quisque maximus facilisis neque. Sed viverra odio elit, ac accumsan magna condimentum vitae. Integer vitae turpis eget leo ornare laoreet." ]
    ]
