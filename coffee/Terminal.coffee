readline  = require 'readline'
http      = require 'http'

String::trim = () -> @replace /^\s+|\s+$/g, ""

class Terminal
  completer: (line, callback) ->
    line = line.trim()
    lineArgs = line.split(' ')
    lineArgs[0] = lineArgs[0].trim()
    completions = (cmd.name for cmd in @terminal.commands)
    hits = completions.filter((c) -> return c.indexOf(lineArgs[0]) == 0)
    hit = completions if hits.length is 0

    #line = lineArgs[0] + ' ' + lineArgs[1]

    #line = line.replace('  ', ' ')
  
    #console.log hits.length

    if hits.length == 1
      for cmd in @terminal.commands
        if cmd.name == hits[0] and cmd.options.length > 0
          completions = (hits[0] + ' ' + opts for opts in cmd.options)
          hits = completions.filter((c) ->
            return c.indexOf(line) == 0)
    callback(null, [hits, line])

  constructor: (@prompt, @commands, @callback) ->
    that = this
    @rl = readline.createInterface
      input: process.stdin
      output: process.stdout
      completer: that.completer
    @rl.terminal = this
    @rl.setPrompt(@prompt)
    @rl.prompt()
    @rl.on 'line', (line) ->
      line = line.trim()
      command = line.split(' ')
      commandMatched = false
      skipPrompt = false
      for cmd in that.commands
        if cmd.name == command[0]
          cmd.action(this, command)
          commandMatched = true
          skipPrompt = cmd.skipPrompt
          break
      if !commandMatched
        console.log("unknown command: #{command}.")
      @prompt() if !skipPrompt
    @rl.on 'close', ->
      that.callback()

  print: () ->
    console.log(@swaggerUrl)

class Command
  constructor: (@name, @action) ->
    @options = []

  clearOptions: (option) ->
    @options = []

  addOption: (option) ->
    @options.push(option)

exports.Command = Command
exports.Terminal = Terminal
