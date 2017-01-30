const fs = require('fs');

const headerInclude = '#ifndef _TEMPLATE_HEADER_\n#define _TEMPLATE_HEADER_\n';
const headerFooter = '#endif';

const sourceDirection = "./src/template"
const buildDirection = './build/template';

module.exports = function() {
    var context = headerInclude;

    fs.readdirSync(sourceDirection).forEach(function(filename) {
        var headerContext = fs.readFileSync(`${sourceDirection}/${filename}`, 'utf8');
        headerContext = headerContext.replace(/\n/g, "\\n\\\n");
        headerContext = headerContext.substring(0, headerContext.length - 4);
        var header = `#define TEMPLATE_${filename.toUpperCase()} "${headerContext}"`;
        context += `\n${header}\n`;
    });

    context += `\n${headerFooter}`;
    fs.writeFileSync(`${buildDirection}.h`, context);
}
