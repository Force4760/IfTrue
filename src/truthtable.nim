import std/math, std/sequtils, tables, sugar

import ast, tabular, helper

type TruthTable* = ref object
    ast: Ast
    vars: OrderedTable[string, bool]
    head: seq[Ast]
    body: seq[seq[bool]]
    lines: int

# Type constructor for a new truth table object
func newTruth*(ast: Ast, vars: OrderedTable[string, bool]): TruthTable =
    return TruthTable(
        ast: ast,
        vars: vars,
        head: ast.subExpr(),
        body: @[],
        lines: 2 ^ len(vars)
    )

# Convert the body to a 2D sequence of strings
# true  -> "T"
# false -> "F"
func bodyToStr(t: TruthTable): seq[seq[string]] =
    return t.body.map(
        (xs) => xs.map(
            (x) => boolToStr(x)
        ) 
    )

# Get the boolean value of a cell in the table
# n -> number of variables in the table
# x -> column number of the cell (starts at 0)
# y -> line number of the cell (starts at 0)
# | 0,0 | 1,0 | 2,0 | 3,0 |
# | 0,1 | 1,1 | 2,1 | 3,1 |
# | 0,2 | 1,2 | 2,2 | 3,2 |
func getCell(n: int, x: int, y: int): bool =
    return y mod 2 ^ (n - x) < 2 ^ (n-x - 1)

# Set the variable table for the values of a given line
# n -> number of variables in the table
# y -> line number of the cell (starts at 0)
proc setRow(t: TruthTable, n: int, y: int) =
    var i = 0
    for k in keys(t.vars):
        t.vars[k] = getCell(len(t.vars), i, y)
        inc i

# Get the truth values for the body of the truth table
proc makeBody(t: TruthTable) =
    # Number of variables
    let n = len(t.vars)

    for i in 0 ..< t.lines:
        # set the variable table to the values 
        # corresponding to this row
        t.setRow(n, i)
        t.body.add(@[])

        # Add the truth values of the variables
        for v in values(t.vars):
            t.body[i].add(v)

        # Evaluate and add the truth values of the expression
        for exp in t.head:
            t.body[i].add(exp.eval(t.vars))

# Convert the TruthTable into a Tabular object
proc toTabular(t: TruthTable): Tabular =
    # Build the Header
    var header: seq[string] = @[]
    
    # Add every variable.
    # Reverse order is used so that the variable appear in the correct form 
    for k in reverse(t.vars):
        header.add(k)

    # Add every expression (as a string) to the header
    for ex in t.head:
        header.add(ex.repr())

    # Generate the body
    let body = t.bodyToStr()

    return newTab(header, body)

func build*(t: TruthTable): Tabular =
    t.makeBody()
    return t.toTabular()