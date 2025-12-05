/*
Devon Sookhoo
December 5th, 2025
Lab 9 ALGOL Create MIPS code from you AST

This emit.h file is the header file for emit.c and exposes the EMIT function prototype.

Enhancements:
  - Created emit.h and emit.c files to handle MIPS code generation
  - #include <stdlib.h> in emit.h for exit()
  - #include <string.h> for strcmp()
  - Defined a macro WSIZE for word size (4 bytes). This can be adjusted if needed depending on the system.
  - Declared the EMIT function prototype so it can be used in other files.
*/

#ifndef EMIT_H
#define EMIT_H

#include <stdlib.h>
#include <string.h>
#include "ast.h"

#define WSIZE 4


// PRE: ASTnode pointer p, file pointer fp
// POST: Generates MIPS code from the AST and writes it to the file
void EMIT(ASTnode*, FILE*);


#endif // EMIT_H

// $ java -jar Mars.jar sm file.asm