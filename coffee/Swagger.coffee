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
    fetchUrl(url, (data) ->
      console.log(data)
      json = JSON.parse data
      console.log(json)
      if json.swaggerVersion == '1.2'
        that.swaggerParent = new SwaggerDoc2(url, json)
        callback()
    )

module.exports = SwaggerDoc
