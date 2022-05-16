import unittest

import helper

test "bool to string - True":
    doAssert boolToStr(true) == "T"

test "bool to string - False":
    doAssert boolToStr(false) == "F"