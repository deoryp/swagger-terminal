readline = require('readline')

String::trim = -> @replace /^\s+|\s+$/g, ""


completer = (line, callback) ->
  line = line.trim()
  completions = 'hello bye exit'.split(' ')
  hits = completions.filter((c) -> return c.indexOf(line) == 0)
  hit = completions if hits.length is 0
  callback(null, [hits, line], line)

class SwaggerTerminal
  constructor: (@prompt, @swaggerUrl, @callback) ->
    @rl = readline.createInterface
      input: process.stdin
      output: process.stdout
      completer: completer

    #@.rl.setPrompt(@prompt)
    @rl.setPrompt(@prompt)
    @rl.prompt()

    @rl.on 'line', (line) ->
      line = line.trim()
      switch line
        when 'hello' then console.log('world!')
        when 'bye' then console.log('son!')
        when 'exit' then @close()
        else console.log('Say what? I might have heard `' + line.trim() + '`')
      @prompt()

    @rl.on 'close', ->
      callback()

  print: () ->
    console.log(@swaggerUrl)

swag = new SwaggerTerminal 'connect:', 'http://something', () ->
  console.log('Have a great day!')
  process.exit(0)


