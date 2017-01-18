all:
	${MAKE} clean ${MAKE} build && ${MAKE} clean || ${MAKE} clean

build:
	${MAKE} clean
	# Building source code
	mkdir -p build
	node ./builder/main.js

	# Compile grammar source
	bison build/grammar.y -vd
	flex src/token/token.l
	cp lex.yy.c build/token.c
	cp grammar.tab.c build/grammar.c
	cp grammar.tab.h build/grammar.h
	# Clean grammar source root
	rm lex.yy.c grammar.tab.c grammar.tab.h

	# Copy main.c to build
	cp src/main.c build/main.c
	# Compile project
	gcc ./build/*.c -o ./bin/wisc
	# Test running
	${MAKE} run

run:
	./bin/wisc testing/test1/main

clean:
	rm -fr build || :
