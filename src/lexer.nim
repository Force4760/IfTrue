import std/strutils

import tokens, rules, helper

type Lexer* = ref object
    input: string
    size:  int
    toks:  seq[Token]
    index: int

# Constructor for the Lexer Type
func newLexer*(input: string): Lexer =
    let inp = input.strip()
    return Lexer(
        input: inp,
        size:  len(inp),
        toks:  @[],
        index: 0,
    )

# Check if the Lexer already viewed the whole input
proc getToks*(l: Lexer): seq[Token] =
    return l.toks

# Check if the Lexer already viewed the whole input
proc isEOF(l: Lexer): bool =
    return l.index >= l.size

# Get the current byte of the input
proc current(l: Lexer): char =
    return l.input[l.index]

# Consume and return every byte that matches a given predicate
proc readWhile(l: Lexer, pred: proc(c: char): bool): string =
    while not l.isEOF() and pred(l.current()):
        result &= l.current()
        l.index += 1

# Turn the input into a a sequence of tokens
proc tokenize*(l: Lexer) =
    # Whilhe the input has not been 100% read
    while not l.isEOF():
        # ignore whitespaces
        let _ = l.readWhile(isWhite)

        var c = l.current()
        var t = zero

        if isOpChar(c):
            # c could be the start of an operation
            # get the full operation and match it
            t = getOp(l.readWhile(isOpChar))
        elif isVarChar(c):
            # c could be a variable
            t = getVar($c)
            l.index += 1
        elif isPuncChar(c):
            # c could be a punctuation
            t = getPunc($c)
            l.index += 1

        # If no token was matched, return an error
        if t.kind == INVALID:
            raise errorLexer(l.index, c)

        # append the matched token to the list of tokens
        l.toks.add(t)
