BIN = ../bin
 
 SOURCES = \
 hp.sml \
 hp.grm.sig \
 hp.grm.sml \
 hp.lex.sml \
 hp.mlb
  
   
.PHONY: all $(SOURCES)
all: $(BIN)/hpdata
.PHONY: clean

clean:
	../../bin/clean
    
hp.grm.sig hp.grm.sml hp.lex.sml: hp.grm hp.lex
	mllex hp.lex
	mlyacc hp.grm
	 
$(BIN)/hpdata: $(SOURCES)
	  mlton -output $(BIN)/hpdata hp.mlb