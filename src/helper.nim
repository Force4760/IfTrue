import tables

# Convert a boolean to a single char string equivalent
# True  -> T
# False -> F
func boolToStr*(b: bool): string =
    return case b:
        of true: "T"
        of false: "F"

# Convert a ordered table to a sequence containing it's keys
func toListK[T, U](t: OrderedTable[T, U]): seq[T] =
    for i in keys(t):
        result.add(i)

# Iterate over an Ordered Table's keys in reverse order
iterator reverseK*[T, U](t: OrderedTable[T, U]): T =
    # Convert to a seq
    let list = t.toListK()

    # Iterate over the seq in reverse order 
    let size = len(list) - 1

    for i in 0 .. size:
        yield list[size - i]


# Convert a ordered table to a sequence containing it's keys
func toListV[T, U](t: OrderedTable[T, U]): seq[U] =
    for i in values(t):
        result.add(i)

# Iterate over an Ordered Table's keys in reverse order
iterator reverseV*[T, U](t: OrderedTable[T, U]): U =
    # Convert to a seq
    let list = t.toListV()

    # Iterate over the seq in reverse order 
    let size = len(list) - 1

    for i in 0 .. size:
        yield list[size - i]