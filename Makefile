CC=        go
BIN=       ./bin
SRC=       ./src
GOCCDIR=   errors lexer parser token util
CLEANDIR=  $(addprefix $(SRC)/, $(GOCCDIR))
GCFLAGS=   -ldflags "-w"
DEBUGFLAGS=-gcflags "-N -l"

all:
	make gogo

.PHONY: gentoken tac gogo clean test

deps:
	gocc -o $(SRC) $(SRC)/lang.bnf

gentoken: $(SRC)/gentoken/gentoken.go
	make deps
	cd $(SRC)/gentoken; $(CC) install $(GCFLAGS)

tac: $(SRC)/tac/tac.go
	cd $(SRC)/tac; $(CC) install $(GCFLAGS)

gogo: $(SRC)/main.go
	go build $(GCFLAGS) -o $(BIN)/gogo $(SRC)/main.go

test:
	scripts/run-tests.sh

clean:
	rm -rf $(CLEANDIR)
	rm -rf $(BIN)
