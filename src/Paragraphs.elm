module Paragraphs exposing (..)

import Types exposing (ContentShorthand(..))
import Html exposing (text, div, br, ul, li)
import Html.Attributes exposing (style)


ampereDesc : ContentShorthand
ampereDesc = Text_ "Working in a small, agile team, responsible for maintaining and enhancing the company website. Playing a key role in the redesign and rewrite of our client-facing platform to improve user experience and performance. Serving as a primary point of contact for the UK office, addressing bug fixes, implementing feature improvements, and incorporating colleague feedback to drive continuous enhancements to our web services."

internshipDesc : ContentShorthand
internshipDesc = Text_ "Liased with digital forensic experts to evaluate existing case evidence capture and storage techniques, and provided a bespoke client-first solution that explored modern improvements to these techniques. Collaborated within a small agile team to produce and test solutions in a tight deadline, focusing on security and encryption on data, as well as mobile app design and development."

blockellDesc : ContentShorthand
blockellDesc = Text_ "A block-based visual programming language that takes inspiration for syntax and semantics from Haskell and other functional programming languages. This project involved the design of a block-based functional programming language and the development of a web-based IDE created in Blockly, to create a tool which aids the teaching of functional languages in education."

activePointsDesc : ContentShorthand
activePointsDesc = Text_ "A dashboard that displays visualisations of healthcare data, collected from Garmin and FitBit smart-watch devices. Created in React, this dashboard connects to a Postgres database for real-time data updates and to a Python ML script for AI-enhanced features."

sotonDesc : ContentShorthand
sotonDesc = Html_
  [ div [] [ text "Modules including Software Engineering Group Project, Advanced Programming Language Concepts, Machine Learning Technologies, Advanced Databases, and Automated Software Verification"]
  , br [] []
  , div []
    [ text "Activities include President and Founder of the Programming Language Society, Marketing Officer for the Electronics and Computer Science Society, and University Ambassador and ECS Student Representative"
    ]
  ]


kingJohnDesc : ContentShorthand
kingJohnDesc = Html_
  [ div [] [ text "Achieved 3 A-Levels in Further Maths, Physics and Maths, with Grades of A* and A. Achieved a BTEC Level 3 National Extended Certificate in Computing, with a Grade of Distinction*"]
  , br [] []
  --, div [] [ text "Achieved 9 GCSE, including Maths, Physics, Computer Science and Media Studies, with Grades of level 9 to 6" ]
  --, br [] []
  , div [] [ text "Activities include representing the school alongside peers in nationwide mathematics competitions for four years in a row, and assisted teaching staff and faculty members as a Prefect" ]
  ]