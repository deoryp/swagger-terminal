util = require 'util'


spawn = require('child_process').spawn
getTermSize = (cb) ->
    spawn('resize').stdout.on('data', (data) ->
        data = String(data)
        lines = data.split('\n'),
            cols = Number(lines[0].match(/^COLUMNS=([0-9]+);$/)[1]),
            lines = Number(lines[1].match(/^LINES=([0-9]+);$/)[1])
        if (cb)
            cb(cols, lines)
    )


getTermSize( (cols, lines) ->

  i = 1
  printit  = () ->
    util.print("\r[")
    for x in [1..(lines-2)]
      if x <= i
        util.print "-"
      else
        util.print " "
    util.print("]")
    i++
    if i <= (lines-2)
      setTimeout printit, 100

  setTimeout printit, 100
)
