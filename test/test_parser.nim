import unittest

import tokens
import ast
import parser

test "Check Semantics 1":
    let par = newParser(@[
        newToken(NOT),
        newToken(VAR),
        newToken(AND),
        newToken(LPAREN),
        newToken(TRUE),
        newToken(OR),
        newToken(FALSE),
        newToken(RPAREN),
    ])

    par.checkSemantics()

test "Check Semantics 2":
    let par = newParser(@[
        newToken(VAR),
        newToken(AND),
        newToken(LPAREN),
        newToken(TRUE),
        newToken(OR),
        newToken(FALSE),
        newToken(IFF),
        newToken(LPAREN),
    ])

    try:
        par.checkSemantics()
        assert false
    except Exception:
        assert true

test "Check Semantics 3":
    let par = newParser(@[
        newToken(VAR),
        newToken(AND),
        newToken(LPAREN),
        newToken(TRUE),
        newToken(OR),
        newToken(FALSE),
        newToken(XOR),
        newToken(RPAREN),
    ])

    try:
        par.checkSemantics()
        assert false
    except Exception:
        assert true

test "Parse 1 !A ^ (T v F)":
    let par = newParser(@[
        newToken(NOT),
        newToken(VAR, "A"),
        newToken(AND),
        newToken(LPAREN),
        newToken(TRUE),
        newToken(OR),
        newToken(FALSE),
        newToken(RPAREN),
    ])

    par.parse()
    doAssert par.getAst().repr() == Ast(
        kind: AND,
        left: Ast(
            kind: NOT,
            right: Ast(
                kind: VAR,
                value: "A"
            )
        ),
        right: Ast(
            kind: OR,
            left: Ast(kind: TRUE),
            right: Ast(kind: FALSE)
        )
    ).repr()