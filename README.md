# wisc
WiScript compiler. Write by C language

# Testing 1 [x]
## Purpose
1. Parsing a single input file [x]
2. Create and variable with available typing [x]
3. Throw error if typing not available and its location [x]

## Error code
2. #100: Syntax error [x]
1. #101: Unknown type '{type name}' [x]

# Testing 2 [ ]
## Purpose
1. Call created variable [x]
2. Expression void [x]
3. Expression boolean [x]
4. Expression int [x]
5. Expression number [x]
6. Expression string [x]
7. Set expression to param [x]
8. Assignment expression to available variable and check if they are match [ ]
9. Display output expression by trace command [ ]

## Matching rule
1. boolean < void
2. int < void
3. number < int

## Error code
1. #102: Variable '{variable name}' already exist [x]
2. #103: Variable '{variable name}' type '{variable type name}' cannot match with '{type name}' [ ]
3. #104: Unknown identifier '{variable name}' [x]
