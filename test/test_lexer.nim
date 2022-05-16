import unittest

import tokens
import lexer

test "lexer 1: A ^ (B x !C)":
    let lex = newLexer("A ^     (B != !C)")
    lex.tokenize()

    doAssert lex.getToks() == @[
        newToken(VAR, "A"),
        newToken(AND, "^"),
        newToken(LPAREN, "("),
        newToken(VAR, "B"),
        newToken(XOR, "!="),
        newToken(NOT, "!"),
        newToken(VAR, "C"),
        newToken(RPAREN, ")"),
    ]

test "lexer 2: Operation":
    let lex = newLexer("! ~ && ^ || v -> > == <-> != ~v ~^ <- <")
    lex.tokenize()

    doAssert lex.getToks() == @[
        newToken(NOT, "!"),
        newToken(NOT, "~"),
        newToken(AND, "&&"),
        newToken(AND, "^"),
        newToken(OR, "||"),
        newToken(OR, "v"),
        newToken(IF, "->"),
        newToken(IF, ">"),
        newToken(IFF, "=="),
        newToken(IFF, "<->"),
        newToken(XOR, "!="),
        newToken(NOR, "~v"),
        newToken(NAND, "~^"),
        newToken(CONV, "<-"),
        newToken(CONV, "<"),
    ]

test "lexer 3: Puntuation":
    let lex = newLexer("()")
    lex.tokenize()

    doAssert lex.getToks() == @[
        newToken(LPAREN, "("),
        newToken(RPAREN, ")"),
    ]

test "lexer 4: Variables":
    let lex = newLexer("T A Z F")
    lex.tokenize()

    doAssert lex.getToks() == @[
        newToken(TRUE, "T"),
        newToken(VAR, "A"),
        newToken(VAR, "Z"),
        newToken(FALSE, "F"),
    ]

test "lexer 5: WhiteSpace error":
    let lex = newLexer(" T A ")
    lex.tokenize()

    doAssert lex.getToks() == @[
        newToken(TRUE, "T"),
        newToken(VAR, "A"),
    ]