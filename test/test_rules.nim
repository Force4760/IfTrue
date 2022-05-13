import unittest

import tokens
import rules

test "WhiteSpaces":
    doAssert isWhite(' ') == true
    doAssert isWhite('\t') == true
    doAssert isWhite('\n') == true
    doAssert isWhite('a') == false

test "Puntuations":
    doAssert isPuncChar('(') == true
    doAssert isPuncChar(')') == true

    doAssert getPunc("(") == newToken(LPAREN, "(")
    doAssert getPunc(")") == newToken(RPAREN, ")")

test "Variables":
    for i in 'A'..'Z':
        doAssert isVarChar(i) == true
        
        case i:
        of 'T': doAssert getVar($i) == newToken(TRUE, "T")
        of 'F': doAssert getVar($i) == newToken(FALSE, "F")
        else: doAssert getVar($i) == newToken(VAR, $i)

test "Operations":
    doAssert isOpChar('!') == true
    doAssert isOpChar('~') == true

    doAssert isOpChar('&') == true
    doAssert isOpChar('^') == true

    doAssert isOpChar('|') == true
    doAssert isOpChar('v') == true

    doAssert isOpChar('x') == true

    doAssert isOpChar('-') == true
    doAssert isOpChar('>') == true
    doAssert isOpChar('<') == true
    doAssert isOpChar('=') == true

    doAssert getOp("!") == newToken(NOT, "!")
    doAssert getOp("~") == newToken(NOT, "~")

    doAssert getOp("&&") == newToken(AND, "&&")
    doAssert getOp("^") == newToken(AND, "^")

    doAssert getOp("||") == newToken(OR, "||")
    doAssert getOp("v") == newToken(OR, "v")

    doAssert getOp("!=") == newToken(XOR, "!=")
    doAssert getOp("x") == newToken(XOR, "x")

    doAssert getOp("->") == newToken(IF, "->")
    doAssert getOp(">") == newToken(IF, ">")

    doAssert getOp("==") == newToken(IFF, "==")
    doAssert getOp("<->") == newToken(IFF, "<->")
