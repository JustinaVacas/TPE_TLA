#!/bin/bash

# access generador folder
cd compiler

# create yacc and lex files
yacc grammar.y -d
lex parser.l

# make the binary
make all

# remove unused files
rm *.o *.yy.c *.tab.c *.tab.h

#return to root folder
cd ..