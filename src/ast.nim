import std/strformat
import std/tables
import tokens

type Ast* = ref object
    kind*: Kind
    left*: Ast
    right*: Ast
    value*: string

func `==`*(a1: Ast, a2: Ast): bool =
    return a1.repr() == a2.repr()

func repr*(a: Ast): string =
    return case a.kind:
    of VAR: a.value
    of TRUE: "T"
    of FALSE: "F"
    of NOT: # Unary Operation
        $NOT & a.right.repr()
    of AND, NAND, OR, NOR, IFF, XOR, IF, CONV: # Binary Operations
        fmt"({a.left.repr()} {a.kind} {a.right.repr()})"
    else: ""

func eval*(a: Ast, t: Table[string, bool]): bool =
    return case a.kind:
    of VAR: t[a.value]
    of TRUE: true
    of FALSE: false
    of NOT: 
        not a.right.eval(t)
    of AND: 
        a.left.eval(t) and a.right.eval(t)
    of NAND:
        not (a.left.eval(t) and a.right.eval(t))
    of OR: 
        a.left.eval(t) or a.right.eval(t)
    of NOR:
        not (a.left.eval(t) or a.right.eval(t))
    of IFF: 
        a.left.eval(t) == a.right.eval(t)
    of XOR: 
        a.left.eval(t) != a.right.eval(t)
    of IF: 
        not a.left.eval(t) or a.right.eval(t)
    of CONV: 
        a.left.eval(t) or not a.right.eval(t)
    else: true