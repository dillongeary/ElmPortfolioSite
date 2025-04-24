module ColorScheme exposing (..)


type Color
  = RoseWater
  | Flamingo
  | Pink
  | Mauve
  | Red
  | Maroon
  | Peach
  | Yellow
  | Green
  | Teal
  | Sky
  | Sapphire
  | Blue
  | Lavender
  | Text
  | Overlay
  | Background


getColor : Color -> String
getColor = getDarkmodeColor


getDarkmodeColor : Color -> String
getDarkmodeColor name = case name of
  RoseWater -> "#f2d5cf"
  Flamingo -> "#eebebe"
  Pink -> "#f4b8e4"
  Mauve -> "#ca9ee6"
  Red -> "#e78284"
  Maroon -> "#ea999c"
  Peach -> "#ef9f76"
  Yellow -> "#e5c890"
  Green -> "#a6d189"
  Teal -> "#81c8be"
  Sky -> "#99d1db"
  Sapphire -> "#85c1dc"
  Blue -> "#8caaee"
  Lavender -> "#babbf1"
  Text -> "#c6d0f5"
  Overlay -> "#737994"
  Background -> "#303446"