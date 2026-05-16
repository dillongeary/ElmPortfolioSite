module Main exposing (..)

import Browser exposing (document)
import Browser.Dom exposing (Viewport, getElement, getViewport, setViewport)
import Components exposing (projectBox, timeLineBox)
import Html exposing (Html, a, div, h1, h2, i, p, text)
import Html.Attributes exposing (class, href, id, style)
import Html.Events exposing (onClick)
import Paragraphs exposing (activePointsDesc, ampereDesc, blockellDesc, internshipDesc, kingJohnDesc, plantFacedDesc, sotonDesc)
import Platform.Cmd exposing (none)
import Task exposing (attempt, perform, sequence)
import Time exposing (every)
import Types exposing (ContentShorthand(..), Model, Msg(..), PageSection(..), Skills(..))



-- MAIN


main =
    document
        { init = init
        , update = update
        , view = viewToDocument view
        , subscriptions = subscriptions
        }



-- DOCUMENT


type alias DocumentType =
    { title : String
    , body : List (Html Msg)
    }


viewToDocument : (Model -> Html Msg) -> Model -> DocumentType
viewToDocument v m =
    { title = "Dillon Geary · Web Developer", body = [ v m ] }



-- MODEL


init : () -> ( Model, Cmd Msg )
init _ =
    ( { viewport = Nothing
      , darkmode = True
      , positions = Nothing
      }
    , none
    )



-- UPDATE


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        GotViewport viewport ->
            ( { model
                | viewport = Just (round viewport.viewport.y)
              }
            , none
            )

        GotPositions result ->
            case result of
                Ok [ eProject, eEducation ] ->
                    ( { model | positions = Just ( round eProject.element.y, round eEducation.element.y ) }, none )

                _ ->
                    ( model, none )

        GetPositionUpdate ->
            ( model
            , attempt GotPositions (sequence [ getElement "HProject", getElement "HEducation" ])
            )

        GetViewportUpdate ->
            ( model
            , perform GotViewport getViewport
            )

        GoTo section ->
            ( model
            , case section of
                Career ->
                    perform (\_ -> NoOp) (setViewport 0 0)

                Projects ->
                    case model.positions of
                        Nothing ->
                            none

                        Just ( i, _ ) ->
                            perform (\_ -> NoOp) (setViewport 0 (toFloat (i - 181)))

                Education ->
                    case model.positions of
                        Nothing ->
                            none

                        Just ( _, i ) ->
                            perform (\_ -> NoOp) (setViewport 0 (toFloat (i - 181)))
            )

        ChangeLightDarkMode ->
            ( { model | darkmode = not model.darkmode }, none )

        NoOp ->
            ( model, none )



-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions _ =
    Sub.batch [ every 50 (\_ -> GetPositionUpdate), every 50 (\_ -> GetViewportUpdate) ]



-- VIEW


getCurrentSection : Model -> PageSection
getCurrentSection model =
    let
        currentYScroll =
            case model.viewport of
                Nothing ->
                    0

                Just i ->
                    i

        ( projectsPosition, educationPosition ) =
            case model.positions of
                Nothing ->
                    ( 1000, 1000 )

                Just i ->
                    i
    in
    case ( (currentYScroll + 381) >= projectsPosition, (currentYScroll + 381) >= educationPosition ) of
        ( False, False ) ->
            Career

        ( True, False ) ->
            Projects

        ( True, True ) ->
            Education

        _ ->
            Education


view : Model -> Html Msg
view model =
    let
        currentSection =
            getCurrentSection model
    in
    div
        [ class
            ("body "
                ++ (if model.darkmode then
                        "dark-mode"

                    else
                        "light-mode"
                   )
            )
        ]
        [ div [ class "content" ]
            [ div
                [ class "flex-col"
                , class "column-padding"
                , class "left-col"
                ]
                [ h1
                    []
                    [ text "Dillon Geary" ]
                , p
                    []
                    [ text "Hi, I’m Dillon! A Brighton-based web developer who loves building clean, creative, and user-friendly applications. Whether it’s large-scale platforms, niche websites, or weird programming languages, I’m happiest when solving tricky problems and bring cool ideas to life." ]
                , div [ class "flex-col", style "gap" "0.5rem", style "min-width" "20rem" ]
                    [ a
                        ([ onClick (GoTo Career)
                         , class "page-link"
                         ]
                            ++ (if currentSection == Career then
                                    [ class "active" ]

                                else
                                    []
                               )
                        )
                        [ text "Career" ]
                    , a
                        ([ onClick (GoTo Projects)
                         , class "page-link"
                         ]
                            ++ (if currentSection == Projects then
                                    [ class "active" ]

                                else
                                    []
                               )
                        )
                        [ text "Projects" ]
                    , a
                        ([ onClick (GoTo Education)
                         , class "page-link"
                         ]
                            ++ (if currentSection == Education then
                                    [ class "active" ]

                                else
                                    []
                               )
                        )
                        [ text "Education" ]
                    ]
                ]
            , div
                [ class "flex-col"
                , class "column-padding"
                , class "right-col"
                ]
                [ div []
                    [ h2 [ id "HCareer" ] [ text "Career" ]
                    , div [ class "flex-col", class "timeline-box" ]
                        [ timeLineBox
                            "Senior Web Developer"
                            "Ampere Analysis"
                            "August 2024 - Current"
                            [ WebDevelopment, React, Django, UI, Database, API ]
                            ampereDesc
                        , timeLineBox
                            "Freelance Web Developer"
                            "Plant Faced Coffee Shop"
                            "March 2026 - Present"
                            [ WebDevelopment, HTML, CSS, UI, ProjectManagement ]
                            plantFacedDesc
                        , timeLineBox
                            "Software Engineer - Intern"
                            "University of Southampton"
                            "June 2023 - September 2023"
                            [ AppDevelopment, Kotlin, Research, UI ]
                            internshipDesc
                        ]
                    ]
                , div []
                    [ h2 [ id "HProject" ] [ text "Projects" ]
                    , div [ class "flex-col", class "timeline-box" ]
                        [ projectBox
                            "A Block-Based Visual Programming Language"
                            "2022 - 2024"
                            [ ProgrammingLanguages, Haskell, WebDevelopment, Research ]
                            blockellDesc
                        , projectBox
                            "Web-Based Medical Data Dashboard"
                            "2023"
                            [ WebDevelopment, React, UI, API ]
                            activePointsDesc
                        ]
                    ]
                , div [ style "min-height" "calc(100vh - calc(2 * var(--vpadding)))" ]
                    [ h2 [ id "HEducation" ] [ text "Education" ]
                    , div [ class "flex-col", class "timeline-box" ]
                        [ timeLineBox
                            "University of Southampton"
                            "First Class MEng Computer Science"
                            "2020 - 2024"
                            []
                            sotonDesc
                        , timeLineBox
                            "The King John School and Sixth Form"
                            ""
                            "2013 - 2020"
                            []
                            kingJohnDesc
                        ]
                    ]
                ]
            ]
        , div
            [ class "colormode-button"
            , onClick ChangeLightDarkMode
            ]
            [ i
                (if model.darkmode then
                    [ class "bi", class "bi-brightness-high-fill" ]

                 else
                    [ class "bi", class "bi-moon-fill" ]
                )
                []
            ]
        , div
            [ class "flex-row"
            , class "footer"
            ]
            [ div [] [ text "Built and powered by ", a [ href "https://elm-lang.org/" ] [ text "Elm" ] ]
            , div [] [ text "Theme by ", a [ href "https://catppuccin.com/" ] [ text "Catppuccin" ] ]
            , div [] [ text "Source code on ", a [ href "https://github.com/dillongeary/dillongeary.github.io" ] [ text "GitHub" ] ]
            ]
        ]
