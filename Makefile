CFLAGS = -I$(CURDIR) std=c99 -D_POSIX_C_SOURCE -Wall -g -pedantic -pedantic-errors -Wextra -fsanitize=address -O3 -Wno-unused-parameter -Wno-implicit-fallthrough -lfl

YACCFLAGS =-d -v -t 

SOURCES_C_LEX=lex.yy.c
SOURCES_C_YACC=y.tab.c
HEADER_C_YACC=y.tab.h

SOURCES_LEX= compiler/parser.l
SOURCES_YACC= compiler/grammar.y

SOURCES_FILES=$(foreach dir,$(SOURCE_DIRS),$(wildcard $(dir)/*.c))
OBJECTS_FILES=$(SOURCES_FILES:.c=.o)

EXECUTABLE_COMPILER=braillee

COMPILER=compiler/*
HASH_MAPS=compiler/hash_maps/*
ERROR_HANLDER=compiler/error_handler/*

SOURCE_DIRS=$(COMPILER_UTILS) $(HASH_MAPS) $(ERROR_HANLDER)

#MAIN DIRECTIVES
all: $(EXECUTABLE_COMPILER) 

$(EXECUTABLE_COMPILER): $(SOURCES_C_LEX) $(SOURCES_C_YACC) $(OBJECTS_FILES)
	$(CC) $(CFLAGS) $^ -o $@

$(SOURCES_C_LEX): $(SOURCES_LEX)
	flex $<

$(SOURCES_C_YACC): $(SOURCES_YACC)
	yacc $(YACCFLAGS) $<

#CLEAN DIRECTIVES
clean:
	rm -rf $(EXECUTABLE_COMPILER) $(SOURCES_C_YACC) $(SOURCES_C_LEX) $(HEADER_C_YACC) $(OBJECTS_FILES) y.output

.PHONY: all clean