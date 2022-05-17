import std/strformat, std/rdstdin

############################################################
# ERRORS
############################################################

func errorLexer*(index: int, character: char): ref Exception =
    return newException(
        Exception,
        fmt"Could not process the character ({$character}) at index {$index}",
    )

func errorParser*(kind: string): ref Exception =
    return newException(
        Exception,
        fmt"The tokens around {kind} can't be processed.",
    )

func errorParen*(): ref Exception =
    return newException(
        Exception,
        "The number of \"(\" and \")\" do not match.",
    )


############################################################
# FUNCTIONS
############################################################

# Convert a boolean to a single char string equivalent
# True  -> T
# False -> F
func boolToStr*(b: bool): string =
    return case b:
        of true: "T"
        of false: "F"

# Check if a string is only composed of whitespace chars
func isAllWhite*(str: string): bool =
    for i in str:
        # All must be ' ', if one is not -> not white space
        if i != ' ': return false

    return true

# Check if a string is only composed of whitespace chars
func count(str: string, c: char): int =
    for i in str:
        if i == c: result += 1

# Ask the user for input until it is not empty
func getInput*(): string =
    var input = ""
    while isAllWhite(input):
        input = readLineFromStdin("Logic Expression: ")

    if count(input, '(') == count(input, ')'):
        return input

    raise errorParen()


