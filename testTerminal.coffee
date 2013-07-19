Terminal = (require './coffee/Terminal.coffee').Terminal
Command = (require './coffee/Terminal.coffee').Command

commands = []

commands.push new Command "swagger", (that, command) ->
  if command.length <= 1
    console.log "swagger requires a url"
    return
  url = command[1]
  index = that.terminal.commands.indexOf(this)
  that.terminal.commands.splice(index, 1)
  console.log 'Downloading ' + url

commands.push(new Command("exit", (that) -> that.close()))

commands.push(new Command("add", (that) ->
  that.terminal.commands.push(new Command('added', -> console.log("howdy")))
))

term = new Terminal('>', commands, ->
  console.log('bye')
  process.exit()
)

