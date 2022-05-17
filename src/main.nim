import lexer, parser, tabular, truthtable, helper

proc inputToTabular*(): Tabular =
    ####################
    ## Input
    ##     
    let input = getInput()

    ####################
    ## LEXER
    ## string -> seq[Tokens]
    ##  
    var lex = newLexer(input)    
    lex.tokenize()
    
    ####################
    ## PARSER
    ## seq[Tokens] -> Ast
    ## 
    let par = newParser(lex.getToks)
    par.parse()
    
    ####################
    ## Truth Table
    ## Ast -> TruthTable -> Tabular
    let truth = newTruth(
        par.getAst(), 
        par.getVars()
    )

    return truth.build()