{Terminal, Command} = (require './coffee/Terminal.coffee')
SwaggerDoc = require './coffee/Swagger.coffee'

url = process.argv[2] if process.argv.length >= 2

commands = []

removeOperations = (that) ->
  removeMe = ['GET', 'POST', 'PUT', 'DELETE']
  removeCommands = []
  for command in that.terminal.commands
    removeCommands.push command if command.name in removeMe
  for command in removeCommands
    index = commands.indexOf(command)
    commands.splice(index, 1)


operationCommandAction = (that, command) ->
  #console.log(this)
  swagger = this.swagger[command[1]]
  console.log swagger

createCommandsFromChildSwagger = (that, swagger) ->
  removeOperations(that)
  operations = {}
  for api in swagger.apis
    for operation in api.operations
      operations[operation.method] = [] if !operations[operation.method]
      operations[operation.method].push(api)
  console.log operations
  for operation, apis of operations
    console.log operation
    opCommand = new Command operation, operationCommandAction
    for api in apis
      #console.log '----'
      #console.log api
      opCommand.addOption api.path
      opCommand.swagger = [] if !opCommand.swagger
      opCommand.swagger[api.path] = api
    #console.log opCommand
    that.terminal.commands.push opCommand

useCommand = new Command "use", (that, command) ->
  that.pause()
  use = command[1] if command.length >= 1
  console.log(' ')
  if use
    that.terminal.swagger.use use, (api) ->
      console.log(that.terminal.swagger.describeApis())
      createCommandsFromChildSwagger(that, api)
      that.setPrompt(use + ' > ')
      that.resume()
      that.prompt()
  else
    console.log that.terminal.swagger.describeApis()
    that.resume()
    that.prompt()
useCommand.skipPrompt = true
 
swaggerCommand = new Command "swagger", (that, command) ->
  if command.length <= 1
    console.log "swagger requires a url"
    that.prompt()
    return
  url = command[1]
  index = that.terminal.commands.indexOf(this)
  that.terminal.commands.splice(index, 1)
  console.log '\nDownloading ' + url + '\n'

  that.pause()

  that.terminal.swagger = new SwaggerDoc url, ->
    console.log that.terminal.swagger.describeApis()
    useCommand.clearOptions()
    for api in that.terminal.swagger.apis()
      useCommand.addOption(api.path)
    that.terminal.commands.push(useCommand)
    that.resume()
    that.prompt()

swaggerCommand.skipPrompt = true
commands.push swaggerCommand

commands.push(new Command("exit", (that) -> that.close()))

term = new Terminal('> ', commands, ->
  console.log('bye')
  process.exit()
)

if url
  swaggerCommand.action(term.rl, ['swagger', url])

