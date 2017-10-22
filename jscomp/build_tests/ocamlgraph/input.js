//@ts-check

var p = require('child_process')
var path = require('path')
var fs = require('fs')
var assert = require('assert')
p.execSync(`bsb`,{cwd: __dirname})

var xs = p.spawnSync('node',
    [path.join(__dirname,'tests','check.bs.js')],
    { encoding: 'ascii'}
).output

var ys= fs.readFileSync(path.join(__dirname,'tests','check.ref'),'ascii')
assert.equal(xs[1],ys)


var xs = p.spawnSync('node',
    [path.join(__dirname,'tests','test_topsort.bs.js')],
    { encoding: 'ascii'}
).output
var ys = fs.readFileSync(path.join(__dirname,'tests','test_topsort.ref'),'ascii')
assert.equal(
    xs[1] , ys
)

var xs = p.spawnSync('node',
    [path.join(__dirname,'tests','test_johnson.bs.js')],
    { encoding: 'ascii'}
).output
var ys = fs.readFileSync(path.join(__dirname,'tests','test_johnson.ref'),'ascii')
assert.equal(
    xs[1], ys
)


// debugger