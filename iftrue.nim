import std/strformat
import src/main, src/tabular

proc main(output: string = "md") = 
    let input = stdin.readLine()

    try:
        let tab = inputToTabular(input)

        echo case output:
            of "md": tab.toMD()
            of "html": tab.toHTML()        
            of "csv": tab.toCSV()        
            of "json": tab.toJSON()
            else: fmt"Invalid output flag: {output}"         

    except Exception as e:
        echo e.msg


main()