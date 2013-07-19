readline  = require 'readline'
http      = require 'http'

String::trim = () -> @replace /^\s+|\s+$/g, ""

completer = (line, callback) ->
  line = line.trim()
  completions = 'hello bye exit'.split(' ')
  hits = completions.filter((c) -> return c.indexOf(line) == 0)
  hit = completions if hits.length is 0
  callback(null, [hits, line], line)

class Terminal
  completer: (line, callback) ->
    line = line.trim()
    completions = (cmd.name for cmd in @terminal.commands)
    hits = completions.filter((c) -> return c.indexOf(line) == 0)
    hit = completions if hits.length is 0
    callback(null, [hits, line], line)

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
      for cmd in that.commands
        if cmd.name == command[0]
          cmd.action(this, command)
          commandMatched = true
          break
      if !commandMatched
        console.log("unknown command: #{command}.")
      @prompt()
    @rl.on 'close', ->
      that.callback()

  print: () ->
    console.log(@swaggerUrl)

class Command
  constructor: (@name, @action) ->

exports.Command = Command
exports.Terminal = Terminal
