# Schedule

## Schedule 3
#### Purpose
- [x] Special type system
- [x] Function special type
- [ ] Define multiple function
- [ ] Calling function
- [ ] Function return
- [x] Define function type
- [ ] Function expression
- [ ] Calling function as expression

#### Error code
- [ ] #105: Function '{variable name}' already define by type '{type name}', cannot match with '{variable name}'
- [ ] #106: Same function param with '{variable name}' already exist
- [x] #107: Cannot define a variable function type like this

#### Warning code
- [ ] #100: Function '{variable name}' define by type '{type name}' don't have return value

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
