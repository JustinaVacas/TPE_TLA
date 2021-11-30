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
# define YYDEBUG 0
#endif
#if YYDEBUG
extern int yydebug;
#endif

/* Token type.  */
#ifndef YYTOKENTYPE
# define YYTOKENTYPE
  enum yytokentype
  {
    START = 258,
    END = 259,
    DELIMITER = 260,
    READ_AND_TRADUCE = 261,
    BRAILLE_TO_TEXT = 262,
    TEXT = 263,
    NUMBER = 264,
    BRAILLE = 265,
    STRING = 266,
    INTEGER = 267,
    VARIABLE = 268,
    MINUS = 269,
    PLUS = 270,
    MULTIPLY = 271,
    DIVIDE = 272,
    LOWER = 273,
    GREATER = 274,
    EQUALS = 275,
    NOT_EQUALS = 276,
    TRUE = 277,
    FALSE = 278,
    AND = 279,
    OR = 280,
    NOT = 281,
    OPEN = 282,
    CLOSE = 283,
    ASSIGN = 284,
    IF = 285,
    ELSE = 286,
    WHILE = 287,
    DO = 288,
    END_IF = 289,
    THEN = 290,
    PRINT = 291,
    NEW_LINE = 292
  };
#endif
/* Tokens.  */
#define START 258
#define END 259
#define DELIMITER 260
#define READ_AND_TRADUCE 261
#define BRAILLE_TO_TEXT 262
#define TEXT 263
#define NUMBER 264
#define BRAILLE 265
#define STRING 266
#define INTEGER 267
#define VARIABLE 268
#define MINUS 269
#define PLUS 270
#define MULTIPLY 271
#define DIVIDE 272
#define LOWER 273
#define GREATER 274
#define EQUALS 275
#define NOT_EQUALS 276
#define TRUE 277
#define FALSE 278
#define AND 279
#define OR 280
#define NOT 281
#define OPEN 282
#define CLOSE 283
#define ASSIGN 284
#define IF 285
#define ELSE 286
#define WHILE 287
#define DO 288
#define END_IF 289
#define THEN 290
#define PRINT 291
#define NEW_LINE 292

/* Value type.  */
#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED
union YYSTYPE
{
#line 10 "grammar.y"

 	int number;
	char * string;

#line 136 "y.tab.h"

};
typedef union YYSTYPE YYSTYPE;
# define YYSTYPE_IS_TRIVIAL 1
# define YYSTYPE_IS_DECLARED 1
#endif


extern YYSTYPE yylval;

int yyparse (void);

#endif /* !YY_YY_Y_TAB_H_INCLUDED  */
