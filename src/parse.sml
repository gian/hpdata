signature PARSE =
sig
	type hpdata 

	val parse : string -> hpdata list
	val toXML : string -> unit
end

structure Parse : PARSE =
struct 
  structure HpLrVals = HpLrValsFun(structure Token = LrParser.Token)
  structure Lex = HpLexFun(structure T = HpLrVals.Tokens)
  structure HpP = Join(structure ParserData = HpLrVals.ParserData
			structure Lex=Lex
			structure LrParser = LrParser)

  type hpdata = HpData.hpdata

  fun parseerror(s,p1,p2) = () 

  fun parse filename = let
	  val file = TextIO.openIn filename
	  fun get _ = TextIO.input file
	  val lexer = LrParser.Stream.streamify (Lex.makeLexer get)
	  val (hp,_) = HpP.parse(30,lexer,parseerror,())
       in TextIO.closeIn file;
	     hp	
      end 

  fun toXML filename = print ("<HPData>\n" ^ HpData.prettyPrint (parse filename) ^ "\n</HPData>\n")
end

structure Main =
struct
	fun main () =
	let val args = CommandLine.arguments ()
	in (Parse.toXML (hd args, hd (tl args));()) end
	end
 
val _ = Main.main ()



