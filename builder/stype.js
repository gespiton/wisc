const fs = require('fs');
const generator = require('./generator.js');

const sgt = generator.sgt;
const gt = generator.gt;
const processStruct = generator.processStruct;

const dataFile = `./builder/structure/stype.json`;
const sourceDirection = './src/stype';
const buildDirection = './build/stype';

const headerInclude = '#ifndef _STYPE_HEADER_\n#define _STYPE_HEADER_\n\n';
const headerFooter = '#endif';
const sourceInclude = '#include <stdio.h>\n#include <stdlib.h>\n#include <string.h>\n\n#include "core.h"\n\n';
const sourceFooter = '';

module.exports = function() {
    var structContext = "";
    var stypeStruct = `typedef struct stype {\n`;
    var stypeDefine = "stype* stype_blank();\n";
    var stypeBlank = "stype* stype_blank() {\n    stype* nstype = (stype*)malloc(sizeof(stype));\n";
    var stypeFunction = "";
    // Loading structure data
    var data = JSON.parse(fs.readFileSync(dataFile, 'utf8'));
    for (var i in data) {
        stypeStruct += `    struct ${i}* ${i};\n`;
        stypeBlank += `    nstype->${i} = NULL;\n`;
        stypeDefine += `stype* stype_${i}(${i}*);\n`;
        stypeFunction += `\nstype* stype_${i}(${i}* ${i}){\n`;
        stypeFunction += `    stype* nstype = (stype*)malloc(sizeof(stype));\n`
        for (var j in data) {
            if (j == i) stypeFunction += `    nstype->${j} = ${i};\n`;
            else stypeFunction += `    nstype->${j} = NULL;\n`;
        }
        stypeFunction += "    return nstype;\n"
        stypeFunction += `}\n`;

        var result = processStruct(i, data[i], sourceDirection, 'stype');
        structContext += '\n' + result.structContext;
        stypeDefine += result.actionContext;
        stypeFunction += result.sourceContext;
    }
    stypeBlank += "    return nstype;\n}\n";
    stypeStruct += "} stype;\n";
    stypeStruct += structContext;

    fs.writeFileSync(`${buildDirection}.h`, headerInclude + stypeStruct + stypeDefine + headerFooter);
    fs.writeFileSync(`${buildDirection}.c`, sourceInclude + stypeBlank + stypeFunction + sourceFooter);
}
