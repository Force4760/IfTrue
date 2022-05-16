# Syntax

## Values
Logic Operations operate on **Values**. This values can be of two kinds: **Variables** or **Booleans**

### Booleans
There are 2 boolean values: **True** and **False**

The **True** value, represented by `T`, as the name suggests, always evaluates to a **logical true**. Similarly, the **False** value, represented as `F`, evaluates to a **logical false**

### Variables
Differently than **Booleans**, **Variables** don't evaluate to a fixed value. They will evaluate to **true** or **false** so that every possible combination is used.

```
1 Var        2 Vars             3 Vars
| A |        | A | B |          | A | B | C |
|---|        |---|---|          |---|---|---|
| F |        | T | T |          | T | T | T |
| T |        | T | F |          | T | T | F |
             | F | T |          | T | F | T |
             | F | F |          | T | F | F |
                                | F | T | T |
                                | F | T | F |
                                | F | F | T |
                                | F | F | F |
```

## Operations
Operations combine values

### And
* Arguments: 2
* Symbols: `^`, `&&` 

```
| A | B | (A ^ B) |
|---|---|---------|
| T | T |    T    |
| T | F |    F    |
| F | T |    F    |
| F | F |    F    |
```

### Nand (Not And)
* Arguments: 2
* Symbols: `~^`, `/` 
* Equivalent: `A / B <=> !(A ^ B)`

```
| A | B | (A / B) |
|---|---|---------|
| T | T |    F    |
| T | F |    T    |
| F | T |    T    |
| F | F |    T    |
```

### Or
* Arguments: 2
* Symbols: `v`, `||` 

```
| A | B | (A v B) |
|---|---|---------|
| T | T |    T    |
| T | F |    T    |
| F | T |    T    |
| F | F |    F    |
```

### Nor (Not or)
* Arguments: 2
* Symbols: `~v`, `\` 
* Equivalent: `A / B <=> !(A ^ B)`

```
| A | B | (A \ B) |
|---|---|---------|
| T | T |    F    |
| T | F |    F    |
| F | T |    F    |
| F | F |    T    |
```

### If
* Arguments: 2
* Symbols: `->`, `>` 

```
| A | B | (A -> B) |
|---|---|----------|
| T | T |     T    |
| T | F |     F    |
| F | T |     T    |
| F | F |     T    |
```

### Nand
* Arguments: 2
* Symbols: `~^`, `/` 
* Equivalent: `A / B <=> !(A ^ B)`

```
| A | B | (A / B) |
|---|---|---------|
| T | T |    F    |
| T | F |    T    |
| F | T |    T    |
| F | F |    T    |
```