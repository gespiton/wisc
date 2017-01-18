const fs = require('fs')

function sgt(type) {
    if (type == "char") return `${type}*`;
    else if (type != "int") return `struct ${type}*`;
    else return type;
}

function gt(type) {
    if (type == "") return type;
    if (type != "int" && type != "void") return `${type}*`;
    else return type;
}

function processCommand(command, type, member, space) {
    var split = command.split(' ');
    if (split[1] == 'malloc') {
        return `${type}* ${split[2]} = (${type}*)malloc(sizeof(${type}));`;
    } else if (split[1] == 'new') {
        var returnString = `${type}* ${split[2]} = (${type}*)malloc(sizeof(${type}));\n`;
        // Building member dictionary object
        for (var i in member) member[i] = member[i][1];
        for (var i = 3; i < split.length; i++)
            if (member[split[i]] && split[i + 1] != undefined) {
                member[split[i]] = split[i + 1];
                i ++;
            }
        for (var i in member)
            returnString += `    ${space}${split[2]}->${i} = ${member[i]};\n`;
        return returnString.substring(0, returnString.length - 1);
        // return returnString;
    } else if (split[1] == 'merge') {
        var list = "";
        for (var i = 2; i < split.length; i ++) {
            list += `,${split[i].replace(/&s/g, " ")}`;
        }
        var returnString = `char* ${split[2]} = merge(${split.length - 2}${list});\n`;
        return returnString;
    } else if (split[1] == 'push') {
        var returnString = `if (${split[2]} == NULL) ${split[2]} = ${split[3]};\n    else {\n        ${type}* ${split[4]} = ${split[2]};\n        while(${split[4]}->next != NULL){\n            ${split[4]}->length += 1;\n            ${split[4]} = ${split[4]}->next;\n        }\n        ${split[4]}->next = ${split[3]};\n    }`;
        return returnString;
    } else return '';
}

function processCode(sourceCode, memberList, type) {
    var returnContext = '{\n';
    sourceCode = sourceCode.split('\n');
    for (var s = 0; s < sourceCode.length - 1; s ++ ) {
        var commandLine = sourceCode[s].split('    ');
        returnContext += '    ';
        var space = '';
        for (var l in commandLine) {
            if (commandLine[l] == '') {
                returnContext += '    ';
                space += '    ';
            } else {
                if (commandLine[l].split(' ')[0] == "#") {
                    returnContext += processCommand(commandLine[l], type, memberList, space);
                } else returnContext += commandLine[l];
                continue;
            }
        }
        returnContext += '\n';
    }
    returnContext += '}\n';
    return returnContext;
}

function processStruct(type, struct, sourceDirection, step) {
    var structContext = "";
    var actionContext = "";
    var sourceContext = "";
    if (fs.existsSync(`${sourceDirection}/${type}`)) {
        structContext = `typedef struct ${type} {\n`;
        // Member list
        var memberList = struct['struct'];
        for (var j in memberList)
            structContext += `    ${sgt(memberList[j][0])} ${j};\n`;
        structContext += `} ${type};\n\n`;

        // Build action define and source code
        var actionList = struct['action'];
        for (var j in actionList) {
            if (fs.existsSync(`${sourceDirection}/${type}/${j}.c`)) {
                // Action return type
                var returnType = gt(actionList[j]['return']);
                var actionParam = actionList[j]['params'];
                // Action define code
                var actionDefine = `${returnType} ${type}_${j}(`;
                for (var h in actionParam)
                    actionDefine += `${gt(actionParam[h])} ${h},`;
                actionDefine = actionDefine.substring(0, actionDefine.length - 1);
                actionDefine += ')';

                // Add to action define code
                actionContext += actionDefine + ';\n';
                // Add to action source code
                sourceContext += `\n${actionDefine} ${processCode(fs.readFileSync(`${sourceDirection}/${type}/${j}.c`, 'utf8'), memberList, type)}`;
            } else console.error(`${step}: ${type}: warning: missing action ${j}`);
        }
        actionContext += '\n';
    } else console.error(`${step}: warning: missing structure ${type}`);
    return { structContext, actionContext, sourceContext }
}

module.exports = {
    sgt, gt, processStruct
}
