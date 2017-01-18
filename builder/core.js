const fs = require('fs');
const generator = require('./generator.js');

const sgt = generator.sgt;
const gt = generator.gt;
const processStruct = generator.processStruct;

const dataFile = `./builder/structure/core.json`;
const sourceDirection = './src/core';
const buildDirection = './build/core';

const coreInclude = "#ifndef _CORE_H_\n#define _CORE_H_\n\n";
const coreFooter = "\n#endif\n";
const sourceInclude = '#include <stdio.h>\n#include <stdlib.h>\n#include <string.h>\n#include <stdarg.h>\n\n#include "core.h"\n\nextern int yyparse(void);\nextern FILE* yyin;\nextern int yyrestart();\n\n';
const sourceFooter = "";

module.exports = function() {
    var coreContext = coreInclude;
    var sourceContext = sourceInclude;

    // Load data file
    var data = JSON.parse(fs.readFileSync(dataFile, 'utf8'));
    // Write include
    var include = data["include"];
    for (var i in include)
        coreContext += `#include "${include[i]}.h"\n`;
    coreContext += '\n';
    // Write define
    var define = data["define"];
    for (var i in define)
        coreContext += `\n#define ${i.toUpperCase()} ${define[i]}`;
    coreContext += '\n';
    // Writting core struct
    var coreStruct = data["struct"];
    for (var i in coreStruct) {
        var result = processStruct(i, coreStruct[i], sourceDirection, 'core');
        coreContext += result.structContext + '\n';
        coreContext += result.actionContext + '\n';
        sourceContext += result.sourceContext + '\n';
    }
    // System param
    var params = data["params"];
    var initContext = "void init(){\n";
    for (var i in params) {
        coreContext += `${gt(params[i][0])} ${i};\n`;
        initContext += `    ${i} = ${params[i][1]};\n`;
    }
    initContext += "}\n";
    sourceContext += initContext;
    // Write source
    var funcs = data["function"];
    coreContext += "void init();";
    for (var i in funcs) {
        if (fs.existsSync(`${sourceDirection}/${i}.c`)) {
            var functionDefine = `\n${gt(funcs[i]['return'])} ${i}(`;
            var params = funcs[i]['params'];
            var hparam = false;
            for (var j in params) {
                functionDefine += `${gt(params[j])} ${j},`;
                hparam = true;
            }
            if (hparam)
                functionDefine = functionDefine.substring(0, functionDefine.length - 1);
            functionDefine += `)`;

            coreContext += functionDefine + ';';
            sourceContext += functionDefine + '{\n';
            var context = fs.readFileSync(`${sourceDirection}/${i}.c`, 'utf8');
            var line = context.split('\n');
            for (var i in line) sourceContext += `    ${line[i]}\n`;
            sourceContext = sourceContext.substring(0, sourceContext.length - 5);
            sourceContext += "}\n";
        } else console.error(`core: warning: missing source ${i}`);
    }
    // console.log(coreContext);
    // console.log(sourceContext);
    fs.writeFileSync(`${buildDirection}.h`, coreContext + coreFooter);
    fs.writeFileSync(`${buildDirection}.c`, sourceContext + sourceFooter);
}
