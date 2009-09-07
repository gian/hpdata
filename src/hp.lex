type pos = int
type svalue = T.svalue
type ('a,'b) token = ('a,'b) T.token
type lexresult = (svalue,pos) token

fun eof() = T.EOF(0,0)

fun err(p1,p2) = print "Error"

%%
%header (functor HpLexFun(structure T : Hp_TOKENS));

%s HP;

num=([0-9]+"."[0-9]+)|([0-9]+);
direction=([NSEW])|([NS][EW]);
time=[0-9]+"/"[0-9]+"Z";
ws=[\.\ \t];
eol=[\n\r];
%%
<INITIAL>{ws}*				=> (YYBEGIN HP; continue());

<HP>"FORECAST"				=> (T.FORECAST(yypos,yypos+8));
<HP>"VALID"					=> (T.VALID(yypos,yypos+5));
<HP>"REMNANT"				=> (T.REMNANT(yypos,yypos+7));
<HP>"LOW"					=> (T.LOW(yypos,yypos+3));
<HP>"INLAND"				=> (T.INLAND(yypos,yypos+6));
<HP>"DISSIPATING"			=> (T.DISSIPATING(yypos,yypos+11));
<HP>"MAX"					=> (T.MAX(yypos,yypos+3));
<HP>"WIND"					=> (T.WIND(yypos,yypos+4));
<HP>"KT"					=> (T.KT(yypos,yypos+2));
<HP>"FT"					=> (T.FT(yypos,yypos+2));
<HP>"MB"					=> (T.MB(yypos,yypos+2));
<HP>"GUSTS"					=> (T.GUSTS(yypos,yypos+5));
<HP>"ESTIMATED"				=> (T.ESTIMATED(yypos,yypos+9));
<HP>"MINIMUM"				=> (T.MINIMUM(yypos,yypos+7));
<HP>"CENTRAL"				=> (T.CENTRAL(yypos,yypos+7));
<HP>"PRESSURE"				=> (T.PRESSURE(yypos,yypos+8));
<HP>"EYE"					=> (T.EYE(yypos,yypos+3));
<HP>"DIAMETER"				=> (T.DIAMETER(yypos,yypos+8));
<HP>"NM"					=> (T.NM(yypos,yypos+2));
<HP>"SUSTAINED"				=> (T.SUSTAINED(yypos,yypos+9));
<HP>"WINDS"					=> (T.WINDS(yypos,yypos+5));
<HP>"WITH"					=> (T.WITH(yypos,yypos+4));
<HP>"SEAS"					=> (T.SEAS(yypos,yypos+4));
<HP>"TO"					=> (T.TO(yypos,yypos+2));
<HP>{num}{direction}		=> (T.GRIDREF(yytext,yypos,yypos+size yytext));
<HP>{time}					=> (T.TIME(yytext,yypos,yypos+size yytext));
<HP>{num}					=> (T.NUM(yytext,yypos,yypos+size yytext));
<HP>{eol}					=> (continue());
<HP>{ws}*					=> (continue());
<HP>.						=> (T.ERROR(yytext,yypos,yypos+size yytext));

