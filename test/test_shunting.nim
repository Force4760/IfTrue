import unittest

import shunting
import tokens

test "shunting 1 !(A ^ B)":
    doAssert inToPre(@[
        newToken(NOT, "!"),
        newToken(LPAREN, "("),
        newToken(VAR, "A"),
        newToken(AND, "&&"),
        newToken(VAR, "B"),
        newToken(RPAREN, ")")
    ]) == @[
        newToken(NOT, "!"),
            newToken(AND, "&&"),
                newToken(VAR, "B"),
                newToken(VAR, "A"),
    ]

test "shunting 2 !(A ^ (B -> A))":
    doAssert inToPre(@[
        newToken(NOT, "!"),
        newToken(LPAREN, "("),
        newToken(VAR, "A"),
        newToken(AND, "&&"),
        newToken(LPAREN, "("),
        newToken(VAR, "B"),
        newToken(IF, "->"),
        newToken(VAR, "A"),
        newToken(RPAREN, ")"),
        newToken(RPAREN, ")"),
    ]) == @[
        newToken(NOT, "!"),
            newToken(AND, "&&"),
                newToken(IF, "->"),
                    newToken(VAR, "A"),
                    newToken(VAR, "B"),
                newToken(VAR, "A"),
    ]

test "shunting 3 C <-> !(A ^ (B -> A))":
    doAssert inToPre(@[
        newToken(VAR, "C"),
        newToken(IFF, "<->"),
        newToken(NOT, "!"),
        newToken(LPAREN, "("),
        newToken(VAR, "A"),
        newToken(AND, "&&"),
        newToken(LPAREN, "("),
        newToken(VAR, "B"),
        newToken(IF, "->"),
        newToken(VAR, "A"),
        newToken(RPAREN, ")"),
        newToken(RPAREN, ")"),
    ]) == @[
        newToken(IFF, "<->"),
            newToken(NOT, "!"),
                newToken(AND, "&&"),
                    newToken(IF, "->"),
                        newToken(VAR, "A"),
                        newToken(VAR, "B"),
                    newToken(VAR, "A"),
            newToken(VAR, "C"),
    ]

test "shunting 4 !C <-> !(A ^ (B -> A v B))":
    doAssert inToPre(@[
        newToken(NOT, "!"),
        newToken(VAR, "C"),
        newToken(IFF, "<->"),
        newToken(NOT, "!"),
        newToken(LPAREN, "("),
        newToken(VAR, "A"),
        newToken(AND, "&&"),
        newToken(LPAREN, "("),
        newToken(VAR, "B"),
        newToken(IF, "->"),
        newToken(VAR, "A"),
        newToken(OR, "||"),
        newToken(VAR, "B"),
        newToken(RPAREN, ")"),
        newToken(RPAREN, ")"),
    ]) == @[
        newToken(IFF, "<->"),
            newToken(NOT, "!"),
                newToken(AND, "&&"),
                    newToken(IF, "->"),
                        newToken(OR, "||"),
                            newToken(VAR, "B"),
                            newToken(VAR, "A"),
                        newToken(VAR, "B"),
                    newToken(VAR, "A"),
            newToken(NOT, "!"),
                newToken(VAR, "C"),
    ]