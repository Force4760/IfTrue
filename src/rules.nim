import tokens

############################################################
# WHITESPACE
############################################################

# Check if a char is WhiteSpace
func isWhite*(c: char): bool =
    return c in "\n\t "

############################################################
# OPERATIONS
############################################################

# Check if a char could be an Op
func isOpChar*(c: char): bool =
    return c in "!~&|^>v<x-="

# Turn string into a Op token
func getOp*(str: string): Token =
    return case str:
        of "^", "&&": newToken(AND, str)
        of "v", "||": newToken(OR, str)
        of "->", ">": newToken(IF, str)
        of "<->", "==": newToken(IFF, str)
        of "!", "~": newToken(NOT, str)
        of "x", "!=": newToken(XOR, str)
        else: newToken(INVALID, str)

############################################################
# Punctuation
############################################################

# Check if a char is Punctuation
func isPuncChar*(c: char): bool =
    return c in "()"

# Turn string into a Punc token
func getPunc*(str: string): Token =
    return case str: 
        of "(": newToken(LPAREN, str)
        of ")": newToken(RPAREN, str)
        else: newToken(INVALID, str)

############################################################
# VARIABLES
############################################################

# Check if a char could be a Variable
func isVarChar*(c: char): bool =
    # is in [A - Z] ?
    return c >= 'A' and c <= 'Z'

# Turn a string into a Var/True/False token
func getVar*(str: string): Token =
    return case str:
        of "T": newToken(TRUE, str)
        of "F": newToken(FALSE, str)
        else: newToken(VAR, str)
