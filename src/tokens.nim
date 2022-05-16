############################################################
# Kinds
############################################################

type Kind* = enum
    INVALID
    TRUE
    FALSE
    VAR
    AND
    NAND
    OR
    NOR
    IF
    CONV
    IFF
    XOR
    NOT
    LPAREN
    RPAREN

# String representation of a Kind
func `$`*(k: Kind): string =
    return case k:
    of TRUE: "T"
    of FALSE: "F"
    of AND: "∧"
    of NAND: "⊼"
    of OR: "v"
    of NOR: "⊽"
    of IF: "->"
    of CONV: "<-"
    of IFF: "<->"
    of XOR: "⨁"
    of NOT: "¬"    
    of LPAREN: "("
    of RPAREN: ")"
    of INVALID: "-"
    of VAR: "VAR"

# Get the precedence of a given Kind
func prec*(k: Kind): int =
    return case k:
    of NOT: 3
    of AND, OR, NAND, NOR: 2
    of IF, IFF, XOR: 1
    else: 0

#[
| Prev                          | Token                 | Next                        |
|-------------------------------|-----------------------|-----------------------------|
| Inv ^ v x -> <-> ! ( <- ~v ~^ | !                     | ( ! Var T F                 |
| Var T F )                     | ^ v x -> <-> <- ~v ~^ | ( ! Var T F                 |
| Inv ( ^ v x -> <-> ! <- ~v ~^ | Var T F               | ) ^ v x -> <-> Inv <- ~v ~^ |
| Inv ( ^ v x -> <-> ! <- ~v ~^ | (                     | Var T F ! (                 |
| Var T F                       | )                     | Inv ) ^ v x -> <-> <- ~v ~^ |
]#
const prevUn* = [LPAREN, INVALID, AND, OR, XOR, IF, IFF, NOT, CONV, NAND, NOR]
const nextUn* = [LPAREN, NOT, VAR, TRUE, FALSE]

const prevBi* = [VAR, TRUE, FALSE, RPAREN]
const nextBi* = [LPAREN, NOT, VAR, TRUE, FALSE]

const prevVal* = [INVALID, LPAREN, NOT, AND, OR, XOR, IF, IFF, CONV, NAND, NOR]
const nextVal* = [INVALID, RPAREN, AND, OR, XOR, IF, IFF, CONV, NAND, NOR]

const prevLP* = [INVALID, LPAREN, AND, OR, XOR, IF, IFF, NOT, CONV, NAND, NOR]
const nextLP* = [VAR, TRUE, FALSE, NOT, LPAREN]

const prevRP* = [VAR, TRUE, FALSE]
const nextRP* = [INVALID, RPAREN, AND, OR, XOR, IF, IFF, CONV, NAND, NOR]

############################################################
# TOKEN TYPE
############################################################

type Token* = object
    kind*:    Kind
    literal*: string

# String representation of a Token
func `$`*(t: Token): string =
    if t.kind == VAR:
        return t.literal
    
    return $t.kind

# Type constructor for the Token type
func newToken*(k: Kind, s: string = ""): Token =
    return Token(kind: k, literal: s)

# zero-value for the Token type
const zero* = newToken(INVALID)