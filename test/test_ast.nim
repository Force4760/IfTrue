import unittest
import tables

import tokens
import ast

test "AST representation":
    doAssert Ast(
        kind: NOT,
        right: Ast(
            kind: AND,
            left: Ast(
                kind: VAR,
                value: "A",
            ),
            right: Ast(
                kind: NOR,
                left: Ast(
                    kind: FALSE,
                    value: "F"
                ),
                right: Ast(
                    kind: TRUE,
                    value: "T"
                )
            )
        )
    ).repr() == "¬(A ∧ (F ⊽ T))"

test "AST eval 1":
    doAssert Ast(
        kind: NOT,
        right: Ast(
            kind: AND,
            left: Ast(
                kind: VAR,
                value: "A",
            ),
            right: Ast(
                kind: OR,
                left: Ast(
                    kind: FALSE,
                    value: "F"
                ),
                right: Ast(
                    kind: TRUE,
                    value: "T"
                )
            )
        )
    ).eval({"A": true}.toOrderedTable()) == false

test "AST eval 2":
    doAssert Ast(
        kind: NOT,
        right: Ast(
            kind: XOR,
            left: Ast(
                kind: VAR,
                value: "A",
            ),
            right: Ast(
                kind: IF,
                left: Ast(
                    kind: VAR,
                    value: "B"
                ),
                right: Ast(
                    kind: FALSE,
                    value: "F"
                )
            )
        )
    ).eval({"A": true, "B": true}.toOrderedTable()) == false

test "AST eval 3":
    doAssert Ast(
        kind: NOT,
        right: Ast(
            kind: XOR,
            left: Ast(
                kind: VAR,
                value: "A",
            ),
            right: Ast(
                kind: IFF,
                left: Ast(
                    kind: VAR,
                    value: "B"
                ),
                right: Ast(
                    kind: FALSE,
                    value: "F"
                )
            )
        )
    ).eval({"A": true, "B": false}.toOrderedTable()) == true