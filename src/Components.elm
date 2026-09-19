module Components exposing (..)

import Html exposing (Attribute, Html, article, h3, header, li, p, text, ul)
import Html.Attributes exposing (class, style)
import List exposing (length, map)
import Types exposing (ContentShorthand(..), Model, Msg, Skills(..))


timeLineBox : String -> String -> List (Html Msg) -> List Skills -> ContentShorthand -> Html Msg
timeLineBox role company date skills desc =
    li []
        [ article []
            ([ header []
                [ h3 [] [ text role ]
                , p [] [ text company ]
                , p [] date
                ]
             ]
                ++ (if length skills > 0 then
                        [ ul []
                            (map (\skill -> skillsBox skill) skills)
                        ]

                    else
                        []
                   )
                ++ handleCS desc
            )
        ]


projectBox : String -> List (Html Msg) -> List Skills -> ContentShorthand -> Html Msg
projectBox title date skills desc =
    li []
        [ article []
            ([ header []
                [ h3 [] [ text title ]
                , p [] date
                ]
             ]
                ++ (if length skills > 0 then
                        [ ul []
                            (map (\skill -> skillsBox skill) skills)
                        ]

                    else
                        []
                   )
                ++ handleCS desc
            )
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
                    ( "teal", "Programming Langauges" )

                Research ->
                    ( "pink", "Research" )

                HTML ->
                    ( "peach", "HTML" )

                CSS ->
                    ( "blue", "CSS" )

                ProjectManagement ->
                    ( "pink", "Project Management" )
    in
    li
        [ class "skills-box"
        , style "background-color" ("var(--" ++ backgroundColor ++ ")")
        ]
        [ text textContent ]


handleCS : ContentShorthand -> List (Html Msg)
handleCS cs =
    case cs of
        Text_ s ->
            [ p [] [ text s ] ]

        Html_ c ->
            c
