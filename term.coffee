readline = require('readline')

String::trim = -> @replace /^\s+|\s+$/g, ""




class SwaggerTerminal
  constructor: (@prompt, @swaggerUrl, @callback) ->
    @.rl = readline.createInterface
      input: process.stdin
      output: process.stdout
    @.rl.setPrompt(@prompt)
    @.rl.prompt()
    @.rl.on 'line', (line) ->
      line = line.trim()
      console.log(line)
      switch line
        when 'hello' then console.log('world!')
        when 'bye' then console.log('son!')
        when 'exit' then rl.close()
        else console.log('Say what? I might have heard `' + line.trim() + '`')
      @.rl.prompt()
    @.rl.on 'close', ->
      @callback()

  print: () ->
    console.log(@swaggerUrl)

swag = new SwaggerTerminal('http://something')

swag.print()

completer = (line, callback) ->
  line = line.trim()
  completions = 'hello bye exit'.split(' ')
  hits = completions.filter((c) -> return c.indexOf(line) == 0)
  hit = completions if hits.length is 0
  callback(null, [hits, line], line)

rl = readline.createInterface
  input: process.stdin
  output: process.stdout
  completer: completer


rl.setPrompt('OHAI> ')
rl.prompt()

rl.on 'line', (line) ->
  line = line.trim()
  console.log(line)
  switch line
    when 'hello' then console.log('world!')
    when 'bye' then console.log('son!')
    when 'exit' then rl.close()
    else console.log('Say what? I might have heard `' + line.trim() + '`')
  rl.prompt()


rl.on 'close', ->
  console.log('Have a great day!')
  process.exit(0)


