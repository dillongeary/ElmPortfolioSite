module HtmlComponents exposing (..)

import Html exposing (Html, div, Attribute, text, h3, span)
import Html.Attributes exposing (style)
import List exposing (map)
import Svg exposing (svg, circle, line)
import Svg.Attributes exposing (width, height, viewBox, cx, cy, r, fill, x1, x2, y1, y2, stroke, strokeWidth, strokeLinecap)

import Types exposing (Model, Msg, ProjectStatus(..), Skills(..))
import ColorScheme exposing (getColor, Color(..))

flexRow : List (Attribute Msg) -> List (Html Msg) -> Html Msg
flexRow a c = div ([ style "display" "flex", style "flex-direction" "row" ] ++ a) c

flexCol : List (Attribute Msg) -> List (Html Msg) -> Html Msg
flexCol a c = div ([ style "display" "flex", style "flex-direction" "column" ] ++ a) c

timeLine : List (Html Msg) -> Html Msg
timeLine c = flexCol [style "gap" "1rem"] c

timeLineBox: Bool -> String -> String -> String -> List Skills -> String -> Html Msg
timeLineBox last role company date skills desc =
  flexRow []
    [ div [ style "flex" "1", style "padding-right" "1rem", style "color" (getColor Overlay) ]
      [ svg
        [ width "40"
        , height "100%"
        , viewBox "0 0 100% 100%"
        , fill "currentColor"
        ]
        (
        [ circle [ cx "50%", cy "11", r "6"] [] ] ++ (if last then [] else [ line [ x1 "50%", x2 "50%", y1 "38", y2 "100%", stroke "currentColor", strokeWidth "2", strokeLinecap "round"] []
        ])
        )
      ]
    , div [  ]
      [ flexCol []
        [ h3 [ style "margin" "0" ] [ text role ]
        , div [ ] [ text company ]
        , div [ style "margin-bottom" "1rem" ] [ text date ]
        , flexRow [ style "margin-bottom" "1rem", style "gap" "0.5rem" ] (map (\skill -> skillsBox skill) skills)
        , text desc
        ]
      ]
    ]


projectBox: String -> ProjectStatus -> String -> List Skills -> String -> Html Msg
projectBox title status date skills desc =
  flexRow []
    [ div [ style "flex" "1", style "padding-right" "1rem", style "color" (getColor Overlay) ]
      [ svg
        [ width "40"
        , height "100%"
        , viewBox "0 0 100% 100%"
        , fill "currentColor"
        ]
        [ circle [ cx "50%", cy "11", r "6"] [] ]
      ]
    , div []
      [ flexCol []
        [ h3 [ style "margin" "0" ]
          [ flexRow [ style "gap" "0.5rem", style "align-items" "center"]
            [ text title
            , statusBox status
            ]
          ]
        , div [ style "margin-bottom" "1rem" ] [ text date ]
        , flexRow [ style "margin-bottom" "1rem", style "gap" "0.5rem" ] (map (\skill -> skillsBox skill) skills)
        , text desc
        ]
      ]
    ]

statusBox: ProjectStatus -> Html Msg
statusBox status =
  let (backgroundColor, textContent) = case status of
                                             Paused -> (Maroon,"Paused")
                                             Ongoing -> (Green, "Ongoing")
                                             Complete -> (Blue, "Complete")

  in statusSkillBox backgroundColor textContent

skillsBox: Skills -> Html Msg
skillsBox skill =
  let (backgroundColor, textContent) = case skill of
                                             WebDevelopment -> (Teal, "Web Development")
                                             AppDevelopment -> (Teal, "App Development")
                                             Haskell -> (Lavender, "Haskell")
                                             JavaScript -> (Yellow, "JavaScript")
                                             Python -> (Yellow, "Python")
                                             Java -> (Peach, "Java")
                                             Kotlin -> (Mauve, "Kotlin")
                                             React -> (Sky, "React")
                                             Django -> (Green, "Django")
                                             UI -> (Flamingo, "UI Design")
                                             Database -> (Flamingo, "Databases")
                                             API -> (Flamingo, "APIs")
                                             ProgrammingLanguages -> (Flamingo,"Programming Langauges")
                                             Research -> (Pink, "Research Project")

  in statusSkillBox backgroundColor textContent


statusSkillBox: Color -> String -> Html Msg
statusSkillBox backgroundColor textContent =
  span
    [ style "padding" "0.2rem 0.4rem"
    , style "background-color" (getColor backgroundColor)
    , style "color" (getColor Background)
    , style "font-size" "0.9rem"
    , style "font-weight" "bold"
    , style "border-radius" "0.2rem"
    ]
    [ text textContent ]