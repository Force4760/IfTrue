import unittest

import tokens

test "Kind representation":
    doAssert $INVALID == "-"
    doAssert $AND == "^"
    doAssert $OR == "v"
    doAssert $IF == "->"
    doAssert $IFF == "<->"
    doAssert $XOR == "x"
    doAssert $NOR == "\\"
    doAssert $NAND == "/"
    doAssert $CONV == "<-"
    doAssert $NOT == "~"
    doAssert $LPAREN == "("
    doAssert $RPAREN == ")"
    doAssert $TRUE == "T"
    doAssert $FALSE == "F"
    doAssert $VAR == "VAR"

test "Token representation":
    doAssert $newToken(INVALID) == "-"
    doAssert $newToken(AND, "&&") == "^"
    doAssert $newToken(OR, "||") == "v"
    doAssert $newToken(IF, ">") == "->"
    doAssert $newToken(IFF, "==") == "<->"
    doAssert $newToken(XOR, "!=") == "x"
    doAssert $newToken(NOR, "~v") == "\\"
    doAssert $newToken(NAND, "~^") == "/"
    doAssert $newToken(NOT, "!") == "~"
    doAssert $newToken(LPAREN, "(") == "("
    doAssert $newToken(RPAREN, ")") == ")"
    doAssert $newToken(TRUE, "T") == "T"
    doAssert $newToken(FALSE, "F") == "F"
    doAssert $newToken(VAR, "A") == "A"
