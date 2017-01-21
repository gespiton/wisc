# Schedule

## Schedule 3
#### Purpose
- [x] Special type system
- [x] Function special type
- [x] Define function
- [x] Function params
- [x] Define multiple function
- [x] Calling multiple function
- [x] Function return
- [x] Define function type
- [ ] Function expression
- [x] Calling function as expression

#### Error code
- [x] #105: Function '{variable name}' already define by type '{type name}', cannot match with '{variable name}'
- [x] #106: Same function param with '{variable name}' already exist
- [x] #107: Cannot define a variable function type like this
- [x] #108: Return not allow here
- [x] #109: Current function was define by type '{type name}' cannot return value type '{type name}'
- [x] #110: Invalid left-hand side in assignment
- [x] #111: '{variable name}' is not a function
- [x] #112: Calling function failed, passing params does not match with any '{function name}'

## Schedule 2 (1/20/17)
#### Purpose
- [x] Call created variable
- [x] Expression void
- [x] Expression boolean
- [x] Expression int
- [x] Expression number
- [x] Expression string
- [x] Set expression to param
- [x] Assignment expression to available variable and check if they are match

#### Matching rule
- [x] boolean < void
- [x] int < void
- [x] number < int

#### Error code
- [x] #102: Variable '{variable name}' already exist
- [x] #103: Variable '{variable name}' type '{variable type name}' cannot match with '{type name}'
- [x] #104: Unknown identifier '{variable name}'

## Schedule 1 (1/19/17)
#### Purpose
- [x] Parsing a single input file
- [x] Create and variable with available typing
- [x] Throw error if typing not available and its location

#### Error code
- [x] #100: Syntax error
- [x] #101: Unknown type '{type name}'
