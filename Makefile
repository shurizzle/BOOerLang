.SUFFIXES: .xrl .yrl .erl

.yrl.erl:
	@echo "YECC $<"
	@erlc -o "$$(dirname $*)" $<

.xrl.erl:
	@echo "LEEX $<"
	@erlc -o "$$(dirname $*)" $<

ebin:
	@mkdir -p ebin

compile: ebin src/booerlang_lexer.erl src/booerlang_parser.erl src/booerlang.erl
	@echo "EMAKE"
	@erl -make

all: compile

clean:
	rm -rf src/booerlang_lexer.erl src/booerlang_parser.erl ebin/*

.PHONY: all compile clean
