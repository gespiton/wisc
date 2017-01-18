const grammar = require('./grammar.js');
const core = require('./core.js')
const ast = require('./ast.js');

// Merge grammar context
console.log('merging grammar source rule');
grammar();
// Build core system
console.log('building core system');
core();
// Build ast source
console.log('building ast source');
ast();
