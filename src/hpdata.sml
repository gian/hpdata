structure HpData =
struct

datatype hpdata = CentralPressure of string
                | EyeDiameter of string
				| WindMax of string
				| GustMax of string
				| WindRadii of string * (string list)
				| SeasRadii of string * (string list)
				| ForecastTrack of string * (string * string) * hpdata list
				| UnknownText of string

type hpdatal = hpdata list

fun pp (CentralPressure s) = "<CentralPressure>" ^ s ^ "</CentralPressure>"
  | pp (EyeDiameter d) = "<EyeDiameter>" ^ d ^ "</EyeDiameter>"
  | pp (WindMax s) = "<WindMax>" ^ s ^ "</WindMax>"
  | pp (GustMax s) = "<GustMax>" ^ s ^ "</GustMax>"
  | pp (WindRadii (p,l)) = "<WindRadii id=\"" ^ p ^ "\">" ^ (String.concatWith "," l) ^ "</WindRadii>"
  | pp (SeasRadii (p,l)) = "<SeasRadii id=\"" ^ p ^ "\">" ^ (String.concatWith "," l) ^ "</SeasRadii>"
  | pp (ForecastTrack (s, (lng,lat), l)) = "<ForecastTrack id=\"" ^ s ^ "\">\n  <Longitude>" ^ lng ^ 
  											"</Longitude>\n  <Latitude>" ^ lat ^ "</Latitude>\n" ^ prettyPrint l ^ "</ForecastTrack>"
  | pp (UnknownText l) = ""
and prettyPrint l = (String.concatWith "\n" (List.filter (fn "" => false | _ => true) (map pp l)))
end

