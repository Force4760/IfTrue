import tables

# Convert a boolean to a single char string equivalent
# True  -> T
# False -> F
func boolToStr*(b: bool): string =
    return case b:
        of true: "T"
        of false: "F"

# Convert a ordered table to a sequence containing it's keys
func toList[T, U](t: OrderedTable[T, U]): seq[T] =
    for i in keys(t):
        result.add(i)

# Iterate over an Ordered Table's keys in reverse order
iterator reverse*[T, U](t: OrderedTable[T, U]): T =
    # Convert to a seq
    let list = t.toList()

    # Iterate over the seq in reverse order 
    let size = len(list) - 1

    for i in 0 .. size:
        yield list[size - i]