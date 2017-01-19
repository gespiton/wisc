# wisc
WiScript compiler. Write by C language

# Testing 1
## Purpose
- [x] Parsing a single input file
- [x] Create and variable with available typing
- [x] Throw error if typing not available and its location

## Error code
- [x] #100: Syntax error
- [x] #101: Unknown type '{type name}'

# Testing 2
## Purpose
- [x] Call created variable
- [x] Expression void
- [x] Expression boolean
- [x] Expression int
- [x] Expression number
- [x] Expression string
- [x] Set expression to param
- [ ] Assignment expression to available variable and check if they are match
- [ ] Display output expression by trace command

## Matching rule
1. boolean < void
2. int < void
3. number < int

## Error code
- [x] #102: Variable '{variable name}' already exist
- [ ] #103: Variable '{variable name}' type '{variable type name}' cannot match with '{type name}'
- [x] #104: Unknown identifier '{variable name}'
