import tokens
import stack

proc processRPAREN(t: Token, outS: Stack, opsS: Stack)
proc processOP(t: Token, outS: Stack, opsS: Stack)
proc process(t: Token, outS: Stack, opsS: Stack)
        
# Convert a list of tokens from infix to prefix
#
# infix --> (prefix shunting yard) --> prefix
proc inToPre*(toks: seq[Token]): seq[Token] =
    # Output stack
    var outS = newStack()
    # Operation stack
    var opsS = newStack()

    # Process every toke in the tokList
    for t in toks:
        process(t, outS, opsS)

    # Pop from the Ops and Push to the Out
    # until the Ops is empty
    while not opsS.isEmpty():
        outS.push(opsS.pop())

    return outS.toSeq()


proc processRPAREN(t: Token, outS: Stack, opsS: Stack) = 
    # Pop from the Ops and Push to the Out
    # until a "(" is found
    while opsS.notEmpty() and opsS.kPeek() != LPAREN:
        outS.push(opsS.pop())

    # Ignore the "("
    opsS.pop()

proc processOP(t: Token, outS: Stack, opsS: Stack) =
    # Precedence of the current token
    let tPrec = t.kind.prec()

    # Pop from the Ops and Push to the Out
    # until the top token does not have greater precedence
    while opsS.notEmpty() and opsS.kPeek().prec > tPrec:
        outS.push(opsS.pop())

    # Push the new token to the Ops
    opsS.push(t)

proc process(t: Token, outS: Stack, opsS: Stack) = 
    case t.kind:
    of VAR, TRUE, FALSE:
        # Just push to the Out 
        outS.push(t)
    of LPAREN:
        # Just push to the Ops
        opsS.push(t)
    of RPAREN:
        processRPAREN(t, outS, opsS)
    else:
        processOP(t, outS, opsS)