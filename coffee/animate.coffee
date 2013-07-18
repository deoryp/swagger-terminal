util = require 'util'
{print} = require 'util'

delay = (ms, func) -> setTimeout func, ms
repeat = (ms, func) -> setInterval func, ms





{spawn} = require 'child_process'

getTermSize = (cb) ->
  spawner = spawn('tput', ['cols'])
  spawner.stderr.on 'data', (data) ->
    process.stderr.write data.toString()
  spawner.stdout.on 'data', (data) ->
    if (cb)
      cb(Number(data))

foo = {}
bar =
  i: 0
  cols: 100


printBar = () ->
  print '\r['
  for x in [1..(bar.cols-2)]
    if x <= bar.i
     print '-'
    else
      print " "
  print ']'
  bar.i++
  if bar.i > (bar.cols-2)
    print '\n'
    clearInterval foo

#getTermSize((cols, lines) -> console.log("here -- > " + cols + " " + lines + "\n"))


getTermSize((cols) ->
  console.log(cols)
  bar.cols = cols
  foo = repeat 10, printBar
)






