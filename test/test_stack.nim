import unittest

import tokens
import stack

test "Push to the Top of the Stack":
    var stk = newStack()
    stk.push(newToken(AND, "^"))
    stk.push(newToken(OR, "v"))
    stk.push(newToken(FALSE, "F"))

    doAssert stk == @[
        newToken(AND, "^"),
        newToken(OR, "v"),
        newToken(FALSE, "F"),
    ]

test "Pop the Top Element of the Stack":
    var stk1 = newStack(@[
        newToken(AND, "^"),
        newToken(OR, "v"),
        newToken(FALSE, "F"),
    ])

    doAssert stk1.pop() == newToken(FALSE, "F")

    doAssert stk1 == @[
        newToken(AND, "^"),
        newToken(OR, "v"),
    ]

    var stk2 = newStack(@[])

    doAssert stk2.pop() == zero

    doAssert stk2 == @[]

test "Peek at the Top of the Stack":
    var stk1 = newStack(@[
        newToken(AND, "^"),
        newToken(OR, "v"),
        newToken(FALSE, "F"),
    ])

    doAssert stk1.peek() == newToken(FALSE, "F")

    doAssert stk1 == @[
        newToken(AND, "^"),
        newToken(OR, "v"),
        newToken(FALSE, "F"),
    ]

    var stk2 = newStack(@[])

    doAssert stk2.peek() == zero

    doAssert stk2 == @[]

test "Peek the Kind at the Top of the Stack":
    var stk1 = newStack(@[
        newToken(AND, "^"),
        newToken(OR, "v"),
        newToken(FALSE, "F"),
    ])

    doAssert stk1.kPeek() == FALSE

    doAssert stk1 == @[
        newToken(AND, "^"),
        newToken(OR, "v"),
        newToken(FALSE, "F"),
    ]

    var stk2 = newStack(@[])

    doAssert stk2.kPeek() == INVALID

    doAssert stk2 == @[]


test "The Size of the Stack":
    doAssert newStack(@[
        newToken(AND, "^"),
        newToken(OR, "v"),
        newToken(FALSE, "F"),
    ]).size() == 3

    doAssert newStack(@[
        newToken(AND, "^"),
        newToken(OR, "v"),
    ]).size() == 2

    doAssert newStack().size() == 0

test "Emptyness of the Stack":
    doAssert newStack().isEmpty() == true
    doAssert newStack().notEmpty() == false
    doAssert newStack(@[newToken(OR, "v")]).isEmpty() == false
    doAssert newStack(@[newToken(OR, "v")]).notEmpty() == true

test "Clearing the Stack":
    var stk1 = newStack()
    stk1.clear()
    doAssert stk1 == @[]

    var stk2 = newStack(@[
        newToken(AND, "^"),
        newToken(OR, "v"),
        newToken(FALSE, "F"),
    ])
    stk2.clear()
    doAssert stk2 == @[]
    
test "Convert a Stack to a Sequence":
    doAssert newStack(@[
        newToken(AND, "^"),
        newToken(OR, "v"),
        newToken(FALSE, "F"),
    ]).toSeq() == @[
        newToken(FALSE, "F"),
        newToken(OR, "v"),
        newToken(AND, "^"),
    ]

    doAssert newStack().toSeq() == @[]