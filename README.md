# Schedule

## Schedule 10
#### Purpose
- [ ] Prototype system
- [ ] Init prototype
- [ ] Calling prototype
- [ ] Special prototype
- [ ] Customize special prototype
- [ ] Generics prototype
- [ ] Matrix special type
- [ ] Matrix define type
- [ ] Matrix expression define
- [ ] Init string prototype
- [ ] Init array prototype
- [ ] Init dictionary prototype
- [ ] Init matrix prototype

## Schedule 9 (3/4/17)
#### Purpose
- [x] Typedef system
- [x] Define type by typedef system
- [x] Any type
- [x] Any type compare
- [x] Any type getting bracket
- [x] Any type calling function
- [x] Any type operator
- [x] Multiple logic operator
- [x] String calling bracket
- [x] Fixed multiple type compare
- [x] Identifier target type
- [x] Single line command
- [x] Multiple line command

#### Error
- [x] #123: Identifier '{Identifier name}' already exists as structure
- [x] #124: Identifier '{Identifier name}' already exists as typedef
- [x] #125: '{variable name}' is type '{type name}' only getting member by an string // string
- [x] #126: Identifier '{Identifier name}' type not exists type '{type name}'

## Schedule 8 (2/4/17)
#### Purpose
- [x] Multiple type system
- [x] Multiple type definition
- [x] Multiple type compare
- [x] Multiple type array expression
- [x] Multiple type dictionary expression

#### Remove Error
- [x] #105: Function '{variable name}' already define by type '{type name}', cannot match with '{variable name}'

## Schedule 7 (1/30/17)
#### Purpose
- [x] Generate javascript file
- [x] WiScript controller
- [x] Module generate
- [x] Assignment generate
- [x] Space variables generate
- [x] If generate
- [x] For generate
- [x] While generate
- [x] Switch generate
- [x] Define function generate
- [x] Function expression generate
- [x] Variable generate name
- [x] Expression generate name
- [x] Identifier generate name

## Schedule 6 (1/28/17)
#### Purpose
- [x] Array special type
- [x] Array expression
- [x] Dictionary special type
- [x] Dictionary expression
- [x] Logic operator
- [x] Const variable
- [x] Bracket identifier

#### Error code
- [x] #117: Cannot define a variable array type like this
- [x] #118: Cannot define a variable array type like this
- [x] #119: '{variable name}' is type '{type name}' cannot getting member
- [x] #120: '{variable name}' is type '{type name}' only getting member by an int // array
- [x] #121: '{variable name}' is type '{type name}' only getting member by an string // dictionary
- [x] #122: '{variable name}' is constant variable cannot be assigned

## Schedule 5 (1/27/17)
#### Purpose
- [x] Operator system
- [x] Commutative operator
- [x] Expression operator
- [x] Initialize system
- [x] Initialize operator grammar
- [x] Initialize file loading
- [x] Initialize operator rule

#### Error code
- [x] #115: Cannot load init file
- [x] #116: Type '{type name}' cannot '{operator symbol}' with '{type name}'

## Schedule 4 (1/24/17)
#### Purpose
- [x] If statement
- [x] Else system
- [x] For statement
- [x] While statement
- [x] Switch statement
- [x] Space controller break
- [x] Space controller continue

#### Error code
- [x] #113: Break not allow here
- [x] #114: Continue not allow here

## Schedule 3 (1/22/17)
#### Purpose
- [x] Special type system
- [x] Function special type
- [x] Define function
- [x] Function params
- [x] Define multiple function
- [x] Calling multiple function
- [x] Function return
- [x] Define function type
- [x] Function expression
- [x] Calling function as expression

#### Error code
- [x] #105: Function '{variable name}' already define by type '{type name}', cannot match with '{variable name}'
- [x] #106: Same function param with '{variable name}' already exist
- [x] #107: Cannot define a variable function type like this
- [x] #108: Return not allow here
- [x] #109: Current function was define by type '{type name}' cannot return value type '{type name}'
- [x] #110: Invalid left-hand side in assignment
- [x] #111: '{variable name}' is not a function
- [x] #112: Calling function failed, passing params '{param list}' does not match with any '{function name}'

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
