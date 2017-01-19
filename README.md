# wisc
WiScript compiler. Write by C language

# Testing

## Testing 1 (1/19/17)
#### Purpose
- [x] Parsing a single input file
- [x] Create and variable with available typing
- [x] Throw error if typing not available and its location

#### Error code
- [x] #100: Syntax error
- [x] #101: Unknown type '{type name}'

## Testing 2 (1/20/17)
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
