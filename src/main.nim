import lexer, parser, tabular, truthtable

proc inputToTabular*(input: string): Tabular = 
    ####################
    ## LEXER
    ## string -> seq[Tokens]  
    var lex = newLexer(input)    
    lex.tokenize()
    
    ####################
    ## PARSER
    ## seq[Tokens] -> Ast
    var par = newParser(lex.getToks)
    par.parse()
    
    ####################
    ## Truth Table
    ## Ast -> TruthTable -> Tabular
    let truth = newTruth(
        par.getAst(), 
        par.getVars()
    )

    return truth.build()