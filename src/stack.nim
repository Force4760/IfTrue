import tokens

# Stack object, a FIFO datastructure that stores Tokens
type Stack* = ref object
    stk: seq[Token]

# Operator overloading to compare a Stack and a Seq
func `==`*(s1: Stack, s2: seq[Token]): bool =
    return s1.stk == s2

# Type Constructor for the Stack object
# stk defaults to the empty sequence
proc newStack*(s: seq[Token] = @[]): Stack =
    return Stack(stk: s)

# Get the number of elements in the stack
proc size*(s: Stack): int =
    return len(s.stk)

# Predicate checking if there are no elements in the Stk
proc isEmpty*(s: Stack): bool =
    return s.size() == 0

# Predicate checking if there are elements in the Stk
proc notEmpty*(s: Stack): bool =
    return s.size() != 0

# Push a new element to the top of the stack
proc push*(s: Stack, elem: Token) =
    s.stk.add(elem)

# Remove and return the top element of the stack
# Returns an INVALID token if he stack is empty
proc pop*(s: Stack): Token {.discardable.} =
    if s.isEmpty():
        return zero
    return s.stk.pop()

# Return the top element of the stack without removing it
# Returns an INVALID token if he stack is empty
proc peek*(s: Stack): Token =
    if s.isEmpty():
        return zero
    return s.stk[s.size() - 1]

# Return the Kind of the top element of the stack without removing it
# Returns INVALID if he stack is empty
proc kPeek*(s: Stack): Kind =
    if s.isEmpty():
        return INVALID
    return s.stk[s.size() - 1].kind

# Removes every element of the stack
proc clear*(s: Stack) =
    s.stk = @[]

# Convert the Stack to a sequence
# empties the stack
proc toSeq*(s: Stack): seq[Token] =
    # Remove every element in the stack (from top to bottom)
    # and add it to the result
    while not s.isEmpty():
        result.add(s.pop())