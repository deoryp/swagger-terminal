url = require 'url'
http = require 'http'

SwaggerDoc2 = require './Swagger1.2.coffee'

fetchUrl = (url, callback) ->
  json = ''
  http.get url, (res) ->
    res.on 'data', (c) -> json += c
    res.on 'end', () -> callback(json)

class SwaggerDoc
  constructor: (url, callback) ->
    that = this
    fetchUrl url, (data) ->
      #console.log(data)
      json = JSON.parse data
      #console.log(json)
      if json.swaggerVersion == '1.2'
        that.swaggerParent = new SwaggerDoc2(url, json)
        callback()
    
  apis: ->
    return @swaggerParent.apis

  describeApis: ->
    aboutApis = ''
    aboutApis += @describeApisAsParent(@swaggerParent)
    aboutApis += '\n' if @inUse
    aboutApis += @describeApisAsChild(@inUse) if @inUse
    return aboutApis

  describeApisAsParent: (swag) ->
    using = null
    if @inUse
      using = @inUse.resourcePath
    #console.log @inUse
    aboutApis = ""
    for api in swag.apis
      inUse = if using == api.path then '*' else ' '
      aboutApis += " #{inUse} #{api.path} - #{api.description}\n"
    return aboutApis

  describeApisAsChild: (swag) ->
    aboutApis = ""
    for api in swag.apis
      for operation in api.operations
        aboutApis += " #{operation.method} #{api.path} - #{operation.summary}\n"
    return aboutApis

  use: (path, callback) ->
    foundPath = false
    for api in @swaggerParent.apis
      if api.path == path
        foundPath = true
        url = @swaggerParent.childUrl(api)
        that = this
        fetchUrl url, (data) ->
          #console.log(data)
          json = JSON.parse data
          #console.log(json)
          if json.swaggerVersion == '1.2'
            that.inUse = new SwaggerDoc2(url, json, true)
            callback(that.inUse) if callback
    console.log('not found') if !foundPath
    callback() if !foundPath

module.exports = SwaggerDoc
