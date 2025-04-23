module Main exposing (..)

-- Press buttons to increment and decrement a counter.
--
-- Read how it works:
--   https://guide.elm-lang.org/architecture/buttons.html
--


import Browser
import Html exposing (..)
import Html.Events exposing (..)
import Html.Attributes exposing (..)
import Browser.Dom exposing (..)
import Platform.Cmd exposing (none)
import Task



-- MAIN


main =
  Browser.document { init = init, update = update, view = (viewToDocument view), subscriptions = (\_ -> Sub.none) }


-- DOCUMENT


type alias DocumentType =
    { title : String
    , body : List (Html Msg)
    }

viewToDocument : (Model -> Html Msg) -> Model -> DocumentType
viewToDocument v m = { title = "Webpage", body = [ v m ] }


-- MODEL


type alias Model =
    { viewport : Maybe Viewport
    }


init : () -> (Model, Cmd Msg)
init _ =
    (
    { viewport = Nothing
    }
    , none
    )


-- UPDATE


type Msg
  = GotViewport Viewport
  | GetViewportClicked


update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
    case msg of
        GotViewport viewport -> ({model | viewport = Just viewport}, none)

        GetViewportClicked -> (model, Task.perform GotViewport getViewport)


-- VIEW

flexRow = [ style "display" "flex", style "flex-direction" "row", style "justify-content" "center", style "min-height" "100vh"]
flexCol = [ style "display" "flex", style "flex-direction" "column", style "flex" "1", style "padding" "5rem", style "box-sizing" "border-box"]

getSceneHeight : Maybe Viewport -> String
getSceneHeight maybeViewport =
    case maybeViewport of
        Just viewport -> String.fromFloat viewport.scene.height
        Nothing -> ""

getViewportY : Maybe Viewport -> String
getViewportY maybeViewport =
    case maybeViewport of
        Just viewport -> String.fromFloat viewport.viewport.y
        Nothing -> ""


view : Model -> Html Msg
view model =
  div flexRow
    [ div (flexCol ++ [style "align-items" "flex-end", style "height" "100vh", style "justify-content" "center", style "position" "sticky", style "top" "0"])
      [ h1 [] [ text "Title" ]
      , div [] [ text (getSceneHeight model.viewport) ]
      , div [] [ text (getViewportY model.viewport) ]
      ]
    , div (flexCol ++ [style "align-items" "flex-start"])
      (List.map (\_ -> div [ style "margin" "5rem 0"] [ text "Row" ]) (List.range 0 100))
    ]