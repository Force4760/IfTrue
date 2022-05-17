import std/strformat

import src/main, src/tabular

proc ifTrue(output = "md") =
    try:
        let tab = inputToTabular()

        echo case output:
            of "md": tab.toMD()
            of "html": tab.toHTML()        
            of "csv": tab.toCSV()        
            of "json": tab.toJSON()
            else: fmt"Invalid output flag: {output}"         

    except Exception as e:
        echo "\n\e[0;31m" & e.msg & "\e[0m\n"


import cligen; dispatch(ifTrue, help = {
    "output": "output format [ md | html | csv | json ]"
})