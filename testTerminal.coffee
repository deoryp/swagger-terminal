Terminal = (require './coffee/Terminal.coffee').Terminal
Command = (require './coffee/Terminal.coffee').Command
SwaggerDoc = require './coffee/Swagger.coffee'

commands = []

useCommand = new Command "use", (that, command) ->
  use = command[1] if command.length >= 1
  console.log that.terminal.swagger.describeApis(use)

commands.push new Command "swagger", (that, command) ->
  if command.length <= 1
    console.log "swagger requires a url"
    return
  url = command[1]
  index = that.terminal.commands.indexOf(this)
  that.terminal.commands.splice(index, 1)
  console.log 'Downloading ' + url

  that.pause()

  that.terminal.swagger = new SwaggerDoc(url, ->
    console.log that.terminal.swagger.describeApis()
    useCommand.clearOptions()
    for api in that.terminal.swagger.apis()
      useCommand.addOption(api.path)
    that.terminal.commands.push(useCommand)
    
    that.resume()
  )

commands.push(new Command("exit", (that) -> that.close()))

addCommand = new Command("add", (that, command) ->
  that.terminal.commands.push(new Command('dadded', -> console.log("howdy")))
)

addCommand.addOption("something")
addCommand.addOption("anything")
addCommand.addOption("nothing")

commands.push(addCommand)

term = new Terminal('> ', commands, ->
  console.log('bye')
  process.exit()
)

