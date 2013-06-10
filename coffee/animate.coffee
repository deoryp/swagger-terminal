util = require 'util'

i = 1
printit  = () ->
  util.print("\r[")
  for x in [1..100]
    if x <= i
      util.print "-"
    else
      util.print " "
  util.print("]")
  i++
  if i <= 100
    setTimeout printit, 100

setTimeout printit, 100
