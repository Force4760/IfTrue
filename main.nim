import tables

import src/lexer, src/parser, src/tabular, src/truthtable

proc main() = 
    let input = stdin.readLine()

    var lex = newLexer(input)    
    try: 
        lex.tokenize()
    except Exception as e:
        echo e.msg
        return

    var par = newParser(lex.getToks)
    try:
        par.parse()
    except Exception as e:
        echo e.msg 
        return

    let a = par.getAst()
    let v = par.getVars()

    var truth = newTruth(a, v).build()

    echo truth.toMD()
    


main()