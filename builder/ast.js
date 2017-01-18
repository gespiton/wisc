const fs = require('fs');
const generator = require('./generator.js');

const sgt = generator.sgt;
const gt = generator.gt;
const processStruct = generator.processStruct;

const dataFile = `./builder/structure/ast.json`;
const sourceDirection = './src/ast';
const buildDirection = './build/ast';

const headerInclude = '#ifndef _AST_HEADER_\n#define _AST_HEADER_\n\n';
const headerFooter = '#endif';
const sourceInclude = '#include <stdio.h>\n#include <stdlib.h>\n#include <string.h>\n\n#include "core.h"\n\n';
const sourceFooter = '';

module.exports = function() {
    var structContext = headerInclude;
    var actionContext = "";
    var sourceContext = sourceInclude;
    // Loading structure data
    var data = JSON.parse(fs.readFileSync(dataFile, 'utf8'));
    for (var i in data) {
        var result = processStruct(i, data[i], sourceDirection, 'ast');
        structContext += result.structContext;
        actionContext += result.actionContext;
        sourceContext += result.sourceContext;
    }

    fs.writeFileSync(`${buildDirection}.h`, structContext + actionContext + headerFooter);
    fs.writeFileSync(`${buildDirection}.c`, sourceContext + sourceFooter);
    // console.log(fs.readFileSync(`${buildDirection}.h`, 'utf8'));
    // console.log("");
    // console.log(fs.readFileSync(`${buildDirection}.c`, 'utf8'));
}
