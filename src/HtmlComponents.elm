module HtmlComponents exposing (..)

import Html exposing (Html, div, Attribute, text, h3)
import Html.Attributes exposing (style)
import Types exposing (Model, Msg)
import Svg exposing (svg, circle, line)
import Svg.Attributes exposing (width, height, viewBox, cx, cy, r, fill, x1, x2, y1, y2, stroke, strokeWidth, strokeLinecap)

flexRow : List (Attribute Msg) -> List (Html Msg) -> Html Msg
flexRow a c = div ([ style "display" "flex", style "flex-direction" "row" ] ++ a) c

flexCol : List (Attribute Msg) -> List (Html Msg) -> Html Msg
flexCol a c = div ([ style "display" "flex", style "flex-direction" "column" ] ++ a) c

timeLine : List (Html Msg) -> Html Msg
timeLine c = flexCol [style "gap" "1rem"] c

timeLineBox: Bool -> (String, String, String) -> Html Msg
timeLineBox last (title, date, desc) =
  flexRow []
    [ div [ style "flex" "1", style "padding-right" "1rem", style "color" "gray" ]
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
        [ h3 [ style "margin" "0" ] [ text title ]
        , div [ style "margin-bottom" "1rem" ] [ text date ]
        , text desc
        ]
      ]
    ]