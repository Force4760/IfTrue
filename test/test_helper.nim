import unittest, tables

import helper

test "bool to string - True":
    doAssert boolToStr(true) == "T"

test "bool to string - False":
    doAssert boolToStr(false) == "F"

test "reverse":
    let t = {"A": 1, "B": 2, "C": 3, "D": 4}.toOrderedTable()

    var testStr = ""
    for i in reverse(t):
        testStr &= i

    doAssert testStr == "DCBA"