CC = gcc
CFLAGS = -Wall -fsanitize=address -Wno-unused-parameter -Wno-implicit-fallthrough
YACCFLAGS = -d -v

C_FILES= *.c
OBJECT_FILES= *.o

SOURCE_DIRS=$(COMPILER) $(HASH_MAPS) $(ERROR_HANLDER)

#MAIN DIRECTIVES
all: clean yaccing lexing compile

compile:
	$(CC) $(CFLAGS) $(C_FILES) -o braille
	@echo "Project compiled."

lexing:
	lex parser.l

yaccing:
	yacc $(YACCFLAGS) grammar.y

#CLEAN DIRECTIVES
clean:
	rm -rf lex.yy.c y.tab.c y.tab.h $(OBJECT_FILES) braille my_program.c y.output

.PHONY: all clean