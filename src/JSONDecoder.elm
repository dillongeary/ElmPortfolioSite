module JSONDecoder exposing (..)

import Json.Decode exposing (Decoder, field, list, map3, map4, map5, string)


type alias Career =
    { role : String
    , company : String
    , date : String
    , skills : List String
    , description : List String
    }


careerDecoder : Decoder Career
careerDecoder =
    map5 Career
        (field "role" string)
        (field "company" string)
        (field "date" string)
        (field "skills" (list string))
        (field "description" (list string))


type alias Project =
    { role : String
    , date : String
    , skills : List String
    , description : List String
    }


projectDecoder : Decoder Project
projectDecoder =
    map4 Project
        (field "role" string)
        (field "date" string)
        (field "skills" (list string))
        (field "description" (list string))


type alias Education =
    { school : String
    , accreditation : String
    , date : String
    , description : List String
    }


educationDecoder : Decoder Education
educationDecoder =
    map4 Education
        (field "school" string)
        (field "accreditation" string)
        (field "date" string)
        (field "description" (list string))


type alias WebsiteData =
    { career : List Career
    , projects : List Project
    , education : List Education
    }


dataDecoder : Decoder WebsiteData
dataDecoder =
    map3 WebsiteData
        (field "career" (list careerDecoder))
        (field "projects" (list projectDecoder))
        (field "education" (list educationDecoder))
