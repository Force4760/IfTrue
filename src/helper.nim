import tables

# Convert a boolean to a single char string equivalent
# True  -> T
# False -> F
func boolToStr*(b: bool): string =
    return case b:
        of true: "T"
        of false: "F"