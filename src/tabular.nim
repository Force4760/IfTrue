import std/sequtils
import std/strutils
import std/strformat
import sugar

# Object representing tabular data
type Tabular* = object
    head: seq[string]
    body: seq[seq[string]]

# Type constructor for Tabular data
func newTab*(head: seq[string], body: seq[seq[string]]): Tabular =
    return Tabular(head: head, body: body)

# Get the CSV representation of the tabular data
func toCSV*(t: Tabular): string =
    # Get the head CSV
    let h = t.head.join(", ") & "\n"
    
    # get the body CSV
    var b = ""
    for row in t.body:
        b &= row.join(", ") & "\n"

    return h & b

# Get the HTML representation of the tabular data
func toHTML*(t: Tabular): string =
    # get the head html
    let h = t.head.map((x) => fmt"<th>{x}</th>").join()
    
    # get the body html
    var b = ""
    for row in t.body:
        b &= "<tr>"
        b &= row.map((x) => fmt"<td>{x}</td>").join()
        b &= "</tr>"

    return fmt"<table><thead>{h}</thead><tbody>{b}</tbody></table>"

# Get the JSON representation of the tabular data
func toJSON*(t: Tabular): string =
    # get the head array
    let h = t.head.map((x) => '"' & x & '"').join(", ")
    
    # get the body 2d-array
    var b: seq[string] = @[]
    for row in t.body:
        b.add("[" & row.map((x) => '"' & x & '"').join(", ") & "]")

    return "{\"head\": [" & h & "], \"body\": [" & b.join(", ") & "]}"