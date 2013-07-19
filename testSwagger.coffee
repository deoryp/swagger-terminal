SwaggerDoc = require './coffee/Swagger.coffee'


petSwagger = new SwaggerDoc 'http://petstore.swagger.wordnik.com/api/api-docs', ->
  console.log("1 petSwagger")
  console.log(petSwagger.swaggerParent.subdocs())

  console.log(petSwagger.apis())
 
  console.log(petSwagger.describeApis()) 

  console.log(petSwagger.describeApis('/pet')) 


