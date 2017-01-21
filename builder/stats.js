const fs = require('fs');
const generator = require('./generator.js');

const sgt = generator.sgt;
const gt = generator.gt;
const processStruct = generator.processStruct;

const dataFile = `./builder/structure/stats.json`;
const sourceDirection = './src/stats';
const buildDirection = './build/stats';

const headerInclude = '#ifndef _STAT_HEADER_\n#define _STAT_HEADER_\n\n';
const headerFooter = '#endif';
const sourceInclude = '#include <stdio.h>\n#include <stdlib.h>\n#include <string.h>\n\n#include "core.h"\n\n';
const sourceFooter = '';

module.exports = function() {
    var actionContext = headerInclude;
    var sourceContext = sourceInclude;
    // Loading structure data
    var data = JSON.parse(fs.readFileSync(dataFile, 'utf8'));
    for (var i in data) {
        if (!fs.existsSync(`${sourceDirection}/${i}.c`)) {
            console.error(`\x1b[33m${'statement'}: warning:\x1b[0m missing ${i}`);
            continue;
        }
        var define = `char* stat_${i}(`;
        for (var j in data[i])
            define += `${gt(data[i][j])} ${j},`;
        define = define.substring(0, define.length - 1);
        define += ")";
        actionContext += define + ";\n";

        var context = " {\n";
        context = fs.readFileSync(`${sourceDirection}/${i}.c`, 'utf8');
        sourceContext += define + ' {\n';
        var line = context.split('\n');
        sourceContext += `    if (parsing_step != STAT || current_space->lock) return "";\n`
        for (var i in line) sourceContext += `    ${line[i]}\n`;
        sourceContext = sourceContext.substring(0, sourceContext.length - 5);
        sourceContext += "}\n";
    }

    fs.writeFileSync(`${buildDirection}.h`, actionContext + headerFooter);
    fs.writeFileSync(`${buildDirection}.c`, sourceContext + sourceFooter);
}
