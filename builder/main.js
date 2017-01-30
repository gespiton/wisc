const grammar = require('./grammar.js');
const core = require('./core.js');
const stype = require('./stype.js');
const ast = require('./ast.js');
const stats = require('./stats.js');
const template = require('./template.js');

// Merge grammar context
console.log('merging grammar source rule');
grammar();
// Build core system
console.log('building core system');
core();
// Build special type
console.log('building special type system');
stype();
// Build ast source
console.log('building ast source');
ast();
// Build statement
console.log('building statement')
stats();
// Build template
console.log('building template');
template();
