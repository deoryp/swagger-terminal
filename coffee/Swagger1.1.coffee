class SwaggerDoc
  constructor: (json) ->
    console.log('parsing json')
    console.log(json)

    if json.swaggerVersion != '1.1'
      console.log 'attempting to parse non-matching swagger verison'
      return

    @swaggerData = JSON.parse json
    @apiVersion = @swaggerData.apiVersion
    @basePath = url.parse(@swaggerData.basePath)
    @apis = for api in @swaggerData.apis
      api.path = api.path.jsonFormat()
      full = url.parse(@swaggerData.basePath)
      full.path += api.path
      #full.href = full.resolve(full.href, full.path)
      full

module.exports = SwaggerDoc
