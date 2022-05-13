import tables

import tokens
import ast
import shunting

type Parser* = ref object
    toks: seq[Token]
    vars: Table[string, bool]
    ast: Ast
    index: int

proc newParser*(toks: seq[Token]): Parser =
    return Parser(toks: toks, index: 0)

func getVars*(p: Parser): Table[string, bool] =
    return p.vars

func getAst*(p: Parser): Ast =
    return p.ast

func current(p: Parser): Token =
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

func checkSemantics*(p: Parser) =
    for t in p.toks:
        case t.kind:
        of NOT:
            if p.kPrev() notin prevUn:
                raise newException(Exception, "")
            if p.kNext() notin nextUn:
                raise newException(Exception, "")

        of AND, OR, XOR, IF, IFF:
            if p.kPrev() notin prevBi:
                raise newException(Exception, "")
            if p.kNext() notin nextBi:
                raise newException(Exception, "")

        of FALSE, TRUE, VAR:
            if p.kPrev() notin prevVal:
                raise newException(Exception, "")
            if p.kNext() notin nextVal:
                raise newException(Exception, "")
        
        of LPAREN:
            if p.kPrev() notin prevLP:
                raise newException(Exception, "")
            if p.kNext() notin nextLP:
                raise newException(Exception, "")
        
        of RPAREN:
            if p.kPrev() notin prevRP:
                raise newException(Exception, "")
            if p.kNext() notin nextRP:
                raise newException(Exception, "")

        else: discard

        p.index += 1

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
        return Ast(
            kind: NOT,
            right: p.buildAst(),
        )
    of AND, OR, IF, IFF, XOR:
        return Ast(
            kind: t.kind,
            right: p.buildAst(),
            left: p.buildAst(),
        )
    else: Ast()

proc parse*(p: Parser) =
    p.checkSemantics()
    p.index = 0

    p.toks = inToPre(p.toks)
    
    p.ast = p.buildAst()
    if p.index != len(p.toks):
        raise newException(Exception, "")