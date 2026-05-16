module Components exposing (..)

import Html exposing (Attribute, Html, div, h3, span, text)
import Html.Attributes exposing (class, style)
import List exposing (length, map)
import Svg exposing (circle, line, svg)
import Svg.Attributes exposing (cx, cy, fill, height, r, stroke, strokeLinecap, strokeWidth, viewBox, width, x1, x2, y1, y2)
import Types exposing (ContentShorthand(..), Model, Msg, Skills(..))


timeLineBox : String -> String -> String -> List Skills -> ContentShorthand -> Html Msg
timeLineBox role company date skills desc =
    div [ class "flex-row" ]
        [ div [ class "timeline" ]
            [ svg
                [ width "40"
                , height "100%"
                , viewBox "0 0 100% 100%"
                , fill "currentColor"
                ]
                [ circle [ cx "50%", cy "11", r "6" ] []
                , line [ x1 "50%", x2 "50%", y1 "38", y2 "100%", stroke "currentColor", strokeWidth "2", strokeLinecap "round" ] []
                ]
            ]
        , div
            [ class "flex-col"
            , class "timeline-text"
            ]
            ([ h3 [ style "margin" "0" ] [ text role ]
             , div [] [ text company ]
             , div [] [ text date ]
             ]
                ++ (if length skills > 0 then
                        [ div
                            [ class "flex-row", class "skills-row" ]
                            (map (\skill -> skillsBox skill) skills)
                        ]

                    else
                        []
                   )
                ++ [ div [ style "margin-top" "0.7rem" ] [ handleCS desc ]
                   ]
            )
        ]


projectBox : String -> String -> List Skills -> ContentShorthand -> Html Msg
projectBox title date skills desc =
    div [ class "flex-row" ]
        [ div [ class "timeline" ]
            [ svg
                [ width "40"
                , height "100%"
                , viewBox "0 0 100% 100%"
                , fill "currentColor"
                ]
                [ circle [ cx "50%", cy "11", r "6" ] [] ]
            ]
        , div [ class "flex-col", class "timeline-text" ]
            [ h3 [ style "margin" "0" ] [ text title ]
            , div [] [ text date ]
            , div [ class "flex-row", class "skills-row" ] (map (\skill -> skillsBox skill) skills)
            , div [ style "margin-top" "0.7rem" ] [ handleCS desc ]
            ]
        ]


skillsBox : Skills -> Html Msg
skillsBox skill =
    let
        ( backgroundColor, textContent ) =
            case skill of
                WebDevelopment ->
                    ( "teal", "Web Development" )

                AppDevelopment ->
                    ( "teal", "App Development" )

                Haskell ->
                    ( "lavender", "Haskell" )

                JavaScript ->
                    ( "yellow", "JavaScript" )

                Python ->
                    ( "yellow", "Python" )

                Java ->
                    ( "peach", "Java" )

                Kotlin ->
                    ( "mauve", "Kotlin" )

                React ->
                    ( "sky", "React" )

                Django ->
                    ( "green", "Django" )

                UI ->
                    ( "flamingo", "UI Design" )

                Database ->
                    ( "flamingo", "Databases" )

                API ->
                    ( "flamingo", "APIs" )

                ProgrammingLanguages ->
                    ( "flamingo", "Programming Langauges" )

                Research ->
                    ( "pink", "Research" )

                HTML ->
                    ( "peach", "HTML" )

                CSS ->
                    ( "blue", "CSS" )

                ProjectManagement ->
                    ( "pink", "Project Management" )
    in
    span
        [ class "skills-box"
        , style "background-color" ("var(--" ++ backgroundColor ++ ")")
        ]
        [ text textContent ]


handleCS : ContentShorthand -> Html Msg
handleCS cs =
    case cs of
        Text_ s ->
            text s

        Html_ c ->
            div [] c
