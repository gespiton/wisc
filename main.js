(function(modules) {
    var installedModules = {};
    var tools = {};
    function require(moduleId) {
        if(installedModules[moduleId])
            return installedModules[moduleId].exports;
        var module = installedModules[moduleId] = {
            exports: {},
            id: moduleId,
            loaded: false
        };
        modules[moduleId].call(module.exports, module, module.exports, require, tools);
        module.loaded = true;
        return module.exports;
    }
    require.m = modules;
    require.c = installedModules;
    require.t = tools;
    return require(0);
}) ([
    function(module, exports, require, tools) {
        ;
        function demo (func) {
            func("12");
        }
        demo(function (str) {
            str = 0.21;
            return str;
        });
    }
])
