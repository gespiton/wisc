var vs = {};
vs.hello = "Hello world"
function demo(pr) {
    pr.hello = "goodbye"
}

console.log(vs.hello);
demo(vs)
console.log(vs.hello);
