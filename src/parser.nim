import tables, system

import tokens
import ast
import shunting

type Parser* = ref object
    toks: seq[Token]
    vars: OrderedTable[string, bool]
    ast: Ast
    index: int

# Constructor for the Parser Type
proc newParser*(toks: seq[Token]): Parser =
    return Parser(toks: toks, index: 0)

# Getter for the vars field of the parser
func getVars*(p: Parser): OrderedTable[string, bool] =
    return p.vars

# Getter for the Ast field of the parser
func getAst*(p: Parser): Ast =
    return p.ast

# Get the current Token the parser points to
# If it's at the EOF -> INVALID
func current(p: Parser): Token =
    # At EOF
    if p.index >= len(p.toks):
        return zero

    return p.toks[p.index]

# Get the Kind of Token after the current one
# If it's at the EOF -> INVALID
func kNext(p: Parser): Kind =
    # At EOF
    if p.index+1 >= len(p.toks):
        return INVALID

    return p.toks[p.index+1].kind


# Get the Kind of Token before the current one
# If it's at the BOF -> INVALID
func kPrev(p: Parser): Kind =
    # At BOF
    if p.index-1 < 0:
        return INVALID

    return p.toks[p.index-1].kind

# Check if the semantics of the tokens are right
# AKA: check if the tokens that comes before and after 
#      every Token are allowed to be in that bosition
func checkSemantics*(p: Parser) =
    for t in p.toks:
        case t.kind:
        of NOT: # Unary
            if p.kPrev() notin prevUn:
                raise newException(Exception, "1")
            if p.kNext() notin nextUn:
                raise newException(Exception, "2")

        of AND, NAND, OR, NOR, IF, IFF, XOR: # Binary
            if p.kPrev() notin prevBi:
                raise newException(Exception, "3")
            if p.kNext() notin nextBi:
                raise newException(Exception, "4")

        of FALSE, TRUE, VAR: # Values
            if p.kPrev() notin prevVal:
                raise newException(Exception, "5")
            if p.kNext() notin nextVal:
                raise newException(Exception, "6")
        
        of LPAREN: # (
            if p.kPrev() notin prevLP:
                raise newException(Exception, "7")
            if p.kNext() notin nextLP:
                raise newException(Exception, "8")
        
        of RPAREN: # )
            if p.kPrev() notin prevRP:
                raise newException(Exception, "9")
            if p.kNext() notin nextRP:
                raise newException(Exception, "10")

        else: discard

        p.index += 1

# Recursively build the Ast
# Leafs are -> Var, True, False
# Nodes are -> Not, And, Nand, Or, Nor, If, Conv, Iff, Xor
proc buildAst(p: Parser): Ast =
    let t = p.current()
    p.index += 1

    case t.kind:
    of VAR:
        p.vars[t.literal] = true
        return Ast(kind: VAR, value: t.literal)
    of FALSE:
        return Ast(kind: FALSE)
    of TRUE:
        return Ast(kind: TRUE)
    of NOT:
        # Unary Operation
        return Ast(
            kind: NOT,
            right: p.buildAst(),
        )
    of AND, NAND, OR, NOR, IF, CONV, IFF, XOR:
        # Binary Operation
        return Ast(
            kind: t.kind,
            right: p.buildAst(),
            left: p.buildAst(),
        )
    else: Ast()

# Execute all of the parsing steps
proc parse*(p: Parser) =
    # Semantics
    p.checkSemantics()
    p.index = 0

    # Shunting yarn: 
    # convert A ^ B to ^ B A
    p.toks = inToPre(p.toks)
    
    # Create the Abstract syntax tree
    p.ast = p.buildAst()

    # Order the variables
    p.vars.sort(system.cmp)
    
    # Check if every token was consummed
    # If not, raise an error
    if p.index != len(p.toks):
        raise newException(
            Exception,
            "The Parser couldn't parse the whole expression."
        )