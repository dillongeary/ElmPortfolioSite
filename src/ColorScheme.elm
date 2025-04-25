module ColorScheme exposing (..)

import Types exposing (Model)


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
  | BackgroundAccent


getGetColor : Model -> (Color -> String)
getGetColor model = case model.darkmode of
    True -> getDarkmodeColor
    False -> getLightmodeColor


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
  BackgroundAccent -> "#232634"

getLightmodeColor : Color -> String
getLightmodeColor name = case name of
  RoseWater -> "#dc8a78"
  Flamingo -> "#dd7878"
  Pink -> "#ea76cb"
  Mauve -> "#8839ef"
  Red -> "#d20f39"
  Maroon -> "#e64553"
  Peach -> "#fe640b"
  Yellow -> "#df8e1d"
  Green -> "#40a02b"
  Teal -> "#179299"
  Sky -> "#04a5e5"
  Sapphire -> "#209fb5"
  Blue -> "#1e66f5"
  Lavender -> "#7287fd"
  Text -> "#4c4f69"
  Overlay -> "#9ca0b0"
  Background -> "#eff1f5"
  BackgroundAccent -> "#dce0e8"