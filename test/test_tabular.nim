import unittest

import tabular

test "CSV":
    doAssert newTab(
        @["A", "B", "A ^ B"],
        @[
            @["T", "T", "T"],
            @["T", "F", "F"],
            @["F", "T", "F"],
            @["F", "F", "F"],
        ],
    ).toCSV() == "A, B, A ^ B\nT, T, T\nT, F, F\nF, T, F\nF, F, F\n"


test "JSON":
    doAssert newTab(
        @["A", "B", "A ^ B"],
        @[
            @["T", "T", "T"],
            @["T", "F", "F"],
            @["F", "T", "F"],
            @["F", "F", "F"],
        ],
    ).toJSON() == "{\"head\": [\"A\", \"B\", \"A ^ B\"], \"body\": [[\"T\", \"T\", \"T\"], [\"T\", \"F\", \"F\"], [\"F\", \"T\", \"F\"], [\"F\", \"F\", \"F\"]]}"


test "HTML":
    doAssert newTab(
        @["A", "B", "A ^ B"],
        @[
            @["T", "T", "T"],
            @["T", "F", "F"],
            @["F", "T", "F"],
            @["F", "F", "F"],
        ],
    ).toHTML() == "<table><thead><th>A</th><th>B</th><th>A ^ B</th></thead><tbody><tr><td>T</td><td>T</td><td>T</td></tr><tr><td>T</td><td>F</td><td>F</td></tr><tr><td>F</td><td>T</td><td>F</td></tr><tr><td>F</td><td>F</td><td>F</td></tr></tbody></table>"   

