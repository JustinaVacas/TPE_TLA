/* A Bison parser, made by GNU Bison 3.5.1.  */

/* Bison interface for Yacc-like parsers in C

   Copyright (C) 1984, 1989-1990, 2000-2015, 2018-2020 Free Software Foundation,
   Inc.

   This program is free software: you can redistribute it and/or modify
   it under the terms of the GNU General Public License as published by
   the Free Software Foundation, either version 3 of the License, or
   (at your option) any later version.

   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU General Public License for more details.

   You should have received a copy of the GNU General Public License
   along with this program.  If not, see <http://www.gnu.org/licenses/>.  */

/* As a special exception, you may create a larger work that contains
   part or all of the Bison parser skeleton and distribute that work
   under terms of your choice, so long as that work isn't itself a
   parser generator using the skeleton or a modified version thereof
   as a parser skeleton.  Alternatively, if you modify or redistribute
   the parser skeleton itself, you may (at your option) remove this
   special exception, which will cause the skeleton and the resulting
   Bison output files to be licensed under the GNU General Public
   License without this special exception.

   This special exception was added by the Free Software Foundation in
   version 2.2 of Bison.  */

/* Undocumented macros, especially those whose name start with YY_,
   are private implementation details.  Do not rely on them.  */

#ifndef YY_YY_Y_TAB_H_INCLUDED
# define YY_YY_Y_TAB_H_INCLUDED
/* Debug traces.  */
#ifndef YYDEBUG
# define YYDEBUG 1
#endif
#if YYDEBUG
extern int yydebug;
#endif

/* Token type.  */
#ifndef YYTOKENTYPE
# define YYTOKENTYPE
  enum yytokentype
  {
    VARIABLE_STRING = 258,
    VARIABLE_INT = 259,
    INT = 260,
    STRING = 261,
    CREATE_VARIABLE_STRING = 262,
    CREATE_VARIABLE_INT = 263,
    TRANSLATE = 264,
    PRINT = 265,
    PRINT_B = 266,
    CONTRACTION = 267,
    ASSIGN = 268,
    DIVIDE_ASSIGN = 269,
    IF = 270,
    ELSE = 271,
    THEN = 272,
    DO = 273,
    WHILE = 274,
    EQ = 275,
    LE = 276,
    GE = 277,
    NEQ = 278,
    AND = 279,
    OR = 280,
    NEW_LINE = 281,
    INNER_BLOCK_START = 282,
    INNER_BLOCK_END = 283
  };
#endif
/* Tokens.  */
#define VARIABLE_STRING 258
#define VARIABLE_INT 259
#define INT 260
#define STRING 261
#define CREATE_VARIABLE_STRING 262
#define CREATE_VARIABLE_INT 263
#define TRANSLATE 264
#define PRINT 265
#define PRINT_B 266
#define CONTRACTION 267
#define ASSIGN 268
#define DIVIDE_ASSIGN 269
#define IF 270
#define ELSE 271
#define THEN 272
#define DO 273
#define WHILE 274
#define EQ 275
#define LE 276
#define GE 277
#define NEQ 278
#define AND 279
#define OR 280
#define NEW_LINE 281
#define INNER_BLOCK_START 282
#define INNER_BLOCK_END 283

/* Value type.  */
#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED
union YYSTYPE
{
#line 23 "compiler/grammar.y"

 	char buffer[1000];
 	node_t * node;
	char * variable

#line 119 "y.tab.h"

};
typedef union YYSTYPE YYSTYPE;
# define YYSTYPE_IS_TRIVIAL 1
# define YYSTYPE_IS_DECLARED 1
#endif


extern YYSTYPE yylval;

int yyparse (node_t * code);

#endif /* !YY_YY_Y_TAB_H_INCLUDED  */
