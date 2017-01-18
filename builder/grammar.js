const fs = require('fs');
const direction = './src/grammar';
const buildDirection = './build/grammar.y';

module.exports = function() {
    var context = fs.readFileSync(`${direction}/header.y`, 'utf8') + "\n";
    fs.readdirSync(direction).forEach(function(fileName) {
        if (fileName != 'header.y')
            context += fs.readFileSync(`${direction}/${fileName}`, 'utf8') + "\n";
    })
    context += "\n%%\n";
    fs.writeFileSync(buildDirection, context);
}
