url = require 'url'

class SwaggerDoc
  constructor: (basePath, json, isChild) ->

    console.log 'SwaggerDoc incoming json = ' + (typeof json)

    if typeof json == 'object'
      @swaggerData = json
    else
      @swaggerData = JSON.parse json

    if @swaggerData.swaggerVersion != '1.2'
      console.log 'attempting to parse non-matching swagger verison'
      return

    @apiVersion = @swaggerData.apiVersion
    @swaggerVersion = @swaggerData.swaggerVersion
    @isChild = isChild

    if !isChild
      @basePath = basePath
      @constructorAsParent()
    else
      @constructorAsChild()

  constructorAsChild: ->
    @basePath = @swaggerData.basePath
    @resourcePath = @swaggerData.resourcePath
    @produces = @swaggerData.produces
    @apis = for api in @swaggerData.apis
      api
    @models = @swaggerData.models

  constructorAsParent: ->
    @apis = for api in @swaggerData.apis
      api
    @authorizations = @swaggerData.authorizations
    @info = @swaggerData.info

  subdocs: ->
    if @isChild
      return []
    else
      apis = for api in @swaggerData.apis
        url.parse(@basePath + api.path)
      return apis

module.exports = SwaggerDoc
