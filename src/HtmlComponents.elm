module HtmlComponents exposing (..)

import Html exposing (Html, div, Attribute, text, h3, span)
import Html.Attributes exposing (style)

import List exposing (map, length)

import Svg exposing (svg, circle, line)
import Svg.Attributes exposing (width, height, viewBox, cx, cy, r, fill, x1, x2, y1, y2, stroke, strokeWidth, strokeLinecap)

import Types exposing (Model, Msg, ProjectStatus(..), Skills(..), ContentShorthand(..))
import ColorScheme exposing (getColor, Color(..))


flexRow : List (Attribute Msg) -> List (Html Msg) -> Html Msg
flexRow a c = div ([ style "display" "flex", style "flex-direction" "row"] ++ a) c


flexCol : List (Attribute Msg) -> List (Html Msg) -> Html Msg
flexCol a c = div ([ style "display" "flex", style "flex-direction" "column" ] ++ a) c


timeLine : Bool -> List (Html Msg) -> Html Msg
timeLine b c = flexCol [style "gap" (if b then "1rem" else "2.5rem")] c


timeLineBox: Bool -> Bool -> String -> String -> String -> List Skills -> ContentShorthand -> Html Msg
timeLineBox last showTimeline role company date skills desc =
  flexRow [] (
    (
    if showTimeline then [ div [ style "flex" "1", style "padding-right" "1rem", style "color" (getColor Overlay) ] [ svg
            [ width "40"
            , height "100%"
            , viewBox "0 0 100% 100%"
            , fill "currentColor"
            ]
            (
            [ circle [ cx "50%", cy "11", r "6"] [] ] ++ (if last then [] else [ line [ x1 "50%", x2 "50%", y1 "38", y2 "100%", stroke "currentColor", strokeWidth "2", strokeLinecap "round"] []
            ])
            )
          ]] else []
    ) ++ [ div [  ]
      [ flexCol []
        (
        [ h3 [ style "margin" "0" ] [ text role ]
        , div [ ] [ text company ]
        , div [ style "margin-bottom" "1rem" ] [ text date ]
        ] ++ (
          if (length skills) > 0
          then [flexRow [ style "margin-bottom" "1rem", style "gap" "0.5rem", style "flex-wrap" "wrap" ] (map (\skill -> skillsBox skill) skills)]
          else []
        ) ++ [ handleCS desc ]
        )
      ]
    ])


projectBox: Bool -> String -> ProjectStatus -> String -> List Skills -> ContentShorthand -> Html Msg
projectBox showTimeline title status date skills desc =
  flexRow [] (
    (if showTimeline then [div [ style "flex" "1", style "padding-right" "1rem", style "color" (getColor Overlay) ] [ svg
            [ width "40"
            , height "100%"
            , viewBox "0 0 100% 100%"
            , fill "currentColor"
            ]
            [ circle [ cx "50%", cy "11", r "6"] [] ]
          ]] else [] ) ++ [  div []
      [ flexCol []
        [ h3 [ style "margin" "0" ]
          [ flexRow [ style "gap" "1em", style "align-items" "center"]
            [ text title
            --, statusBox status
            ]
          ]
        , div [ style "margin-bottom" "1rem" ] [ text date ]
        , flexRow [ style "margin-bottom" "1rem", style "gap" "0.5rem", style "flex-wrap" "wrap" ] (map (\skill -> skillsBox skill) skills)
        , handleCS desc
        ]
      ]
    ])


statusSkillBox: Color -> String -> Html Msg
statusSkillBox backgroundColor textContent =
  span
    [ style "padding" "0.2rem 0.4rem"
    , style "background-color" (getColor backgroundColor)
    , style "color" (getColor Background)
    , style "font-size" "0.9rem"
    , style "font-weight" "bold"
    , style "border-radius" "0.2rem"
    , style "box-shadow" "0 2px #00000020"
    ]
    [ text textContent ]


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
                                             Research -> (Pink, "Research")

  in statusSkillBox backgroundColor textContent


handleCS : ContentShorthand -> Html Msg
handleCS cs = case cs of
    Text_ s -> text s
    Html_ c -> div [] c