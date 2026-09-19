port module Main exposing (..)

import Browser exposing (document)
import Browser.Dom exposing (Viewport, getElement, getViewport, setViewport)
import Components exposing (projectBox, timeLineBox)
import Html exposing (Html, a, button, footer, h1, h2, header, i, nav, ol, p, section, text, time, ul)
import Html.Attributes exposing (class, datetime, href, id)
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


viewToDocument : (Model -> List (Html Msg)) -> Model -> DocumentType
viewToDocument v m =
    { title = "Dillon Geary · Web Developer", body = v m }



-- MODEL


init : () -> ( Model, Cmd Msg )
init _ =
    ( { viewport = Nothing
      , darkmode = True
      , positions = Nothing
      }
    , setBodyClass "dark-mode"
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
            , attempt GotPositions (sequence [ getElement "projects", getElement "education" ])
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
            let
                targetMode =
                    not model.darkmode
            in
            ( { model | darkmode = targetMode }
            , setBodyClass
                (if targetMode then
                    "dark-mode"

                 else
                    "light-mode"
                )
            )

        NoOp ->
            ( model, none )



-- PORTS


port setBodyClass : String -> Cmd msg



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
    case ( (currentYScroll + 100) >= projectsPosition, (currentYScroll + 100) >= educationPosition ) of
        ( False, False ) ->
            Career

        ( True, False ) ->
            Projects

        ( True, True ) ->
            Education

        _ ->
            Education


view : Model -> List (Html Msg)
view model =
    let
        currentSection =
            getCurrentSection model
    in
    [ header
        []
        [ h1
            []
            [ text "Dillon Geary" ]
        , p
            []
            [ text "Hi, I’m Dillon! A Brighton-based web developer who loves building clean, creative, and user-friendly applications. Whether it’s large-scale platforms, niche websites, or weird programming languages, I’m happiest when solving tricky problems and bringing cool ideas to life." ]
        , nav []
            [ a
                ([ href "#career"
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
                ([ href "#projects"
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
                ([ href "#education"
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
    , section [ id "career" ]
        [ h2 [] [ text "Career" ]
        , ol [ class "lined-list" ]
            [ timeLineBox
                "Senior Web Developer"
                "Ampere Analysis"
                [ time [ datetime "2024-08" ] [ text "August 2024" ], text " - ", text "Present" ]
                [ WebDevelopment, UI, Database, API, React, Django ]
                ampereDesc
            , timeLineBox
                "Freelance Web Developer"
                "Plant Faced Coffee Shop"
                [ time [ datetime "2026-03" ] [ text "March 2026" ], text " - ", text "Present" ]
                [ WebDevelopment, UI, HTML, CSS, ProjectManagement ]
                plantFacedDesc
            , timeLineBox
                "Software Engineer - Intern"
                "University of Southampton"
                [ time [ datetime "2023-06" ] [ text "June 2023" ], text " - ", time [ datetime "2023-09" ] [ text "September 2023" ] ]
                [ AppDevelopment, UI, Kotlin, Research ]
                internshipDesc
            ]
        ]
    , section [ id "projects" ]
        [ h2 [] [ text "Projects" ]
        , ul [ class "unlined-list" ]
            [ projectBox
                "A Block-Based Visual Programming Language"
                [ time [ datetime "2022" ] [ text "2022" ], text " - ", time [ datetime "2024" ] [ text "2024" ] ]
                [ ProgrammingLanguages, WebDevelopment, Haskell, Research ]
                blockellDesc
            , projectBox
                "Web-Based Medical Data Dashboard"
                [ time [ datetime "2023" ] [ text "2023" ] ]
                [ WebDevelopment, UI, API, React ]
                activePointsDesc
            ]
        ]
    , section [ id "education" ]
        [ h2 [] [ text "Education" ]
        , ol [ class "lined-list" ]
            [ timeLineBox
                "University of Southampton"
                "First Class MEng Computer Science"
                [ time [ datetime "2020" ] [ text "2020" ], text " - ", time [ datetime "2024" ] [ text "2024" ] ]
                []
                sotonDesc
            , timeLineBox
                "The King John School and Sixth Form"
                ""
                [ time [ datetime "2013" ] [ text "2013" ], text " - ", time [ datetime "2020" ] [ text "2020" ] ]
                []
                kingJohnDesc
            ]
        ]
    , button
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
    , footer
        [ class "footer"
        ]
        [ p [] [ text "Built and powered by ", a [ href "https://elm-lang.org/" ] [ text "Elm" ] ]
        , p [] [ text "Theme by ", a [ href "https://catppuccin.com/" ] [ text "Catppuccin" ] ]
        , p [] [ text "Source code on ", a [ href "https://github.com/dillongeary/dillongeary.github.io" ] [ text "GitHub" ] ]
        ]
    ]
