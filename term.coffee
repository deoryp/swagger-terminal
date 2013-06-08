readline  = require 'readline'
http      = require 'http'
url       = require 'url'

String::trim = -> @replace /^\s+|\s+$/g, ""

String::jsonFormat = ->
  this.replace /\.\{format\}/g, ".json"

completer = (line, callback) ->
  line = line.trim()
  completions = 'hello bye exit'.split(' ')
  hits = completions.filter((c) -> return c.indexOf(line) == 0)
  hit = completions if hits.length is 0
  callback(null, [hits, line], line)


class SwaggerDoc
  constructor: (json) ->
    console.log('parsing json')
    console.log(json)
    @swaggerData = JSON.parse json
    @apiVersion = @swaggerData.apiVersion
    @basePath = url.parse(@swaggerData.basePath)
    @apis = for api in @swaggerData.apis
      api.path = api.path.jsonFormat()
      full = url.parse(@swaggerData.basePath)
      full.path += api.path
      console.log("#{full.host}#{full.path}")
      full

fetchUrl = (url, callback) ->
  json = ''
  http.get url, (res) ->
    res.on 'data', (c) -> json += c
    res.on 'end', () ->
      callback(json)

fetchSwagger = (options, callback) ->
    fetchUrl options, (json) ->
      swagger = new SwaggerDoc(json)
      for api in swagger.apis
        fetchUrl api, (json) ->
          api.swagger = new SwaggerDoc(json)

    ###
    http.get options, (res) ->
      json = ''
      res.on 'data', (c) -> json += c
      res.on 'end', () ->
        swagger = new SwaggerDoc(json)
        for api in swagger.apis
          json = ''
          http.get api, (res) ->
            res.on 'data', (c) -> json += c
            res.on 'end', () ->
              subdoc = new SwaggerDoc(json)
              console.log(subdoc)
    
    ###

class SwaggerTerminal
  constructor: (@prompt, @swaggerUrl, @callback) ->
    options = url.parse(@swaggerUrl)
    fetchSwagger options, () ->
      console.log 'done fetching swagger'

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

swag = new SwaggerTerminal 'connect:', 'http://petstore.swagger.wordnik.com/api/api-docs.json', () ->
  console.log('Have a great day!')
  process.exit(0)


