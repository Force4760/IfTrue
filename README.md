# IfTrue
Command line interface for building Logic tables from a given logic expression.

## Stack
* Languages: Nim
* Libraries: cligen 

## Instalation

1. Install the **Nim** language, as explained in [this guide](https://nim-lang.org/install_unix.html)

2. Install cligen by running thefollowing command inside your terminal

```bash
$ nimble install cligen
```

3. Clone this repository

```bash
$ git clone https://github.com/Force4760/IfTrue.git
```

4. Build the binary

```bash
$ nim c iftrue.nim
```

5. [Optional] Add the binary to your path

## Syntax

```bnf
<bool>  ::= <true> | <false>
<true>  ::= "T"
<false> ::= "F"

<var> ::= "A" | "B" | "C" | "D" | "E" | "G" | "H" | "I" | "J" | "K" | "L" | "M" | "N" | "O" | "P" | "Q" | "R" | "S" | "U" | "V" | "W" | "X" | "Y" | "Z"

<and>  ::= <expr>  <andOp>  <expr>
<nand> ::= <expr>  <nandOp> <expr> 
<or>   ::= <expr>  <orOp>   <expr>
<nor>  ::= <expr>  <norOp>  <expr>
<if>   ::= <expr>  <ifOp>   <expr>
<con>  ::= <expr>  <conOp>  <expr>
<iff>  ::= <expr>  <iffOp>  <expr>
<xor>  ::= <expr>  <xorOp>  <expr> 
<not>  ::= <notOp> <expr>

<andOp>  ::= "&&" | "^" 
<nandOp> ::= "~^" | "/"
<orOp>   ::= "||" | "v"
<norOp>  ::= "~v" | "\"
<ifOp>   ::= ">"  | "->" 
<conOp>  ::= "<"  | "<-" 
<iffOp>  ::= "==" | "<->"
<xorOp>  ::= "!=" | "x"
<notOp>  ::= "!"  | "~"

<operation> ::= <and> | <or> | <if> | <con> | <iff> | <nand> | <nor> | <xor> | <not>

<expr> ::= "(" <expr> ")" | <operation> | <var> | <bool>
```

## How To Help
* Write Tests
* Report bugs
* Make feature suggestions
* Use the software