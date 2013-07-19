SwaggerDoc = require './coffee/Swagger1.2.coffee'

pet = '{"apiVersion":"1.0.0","swaggerVersion":"1.2","apis":[{"path":"/pet","description":"Operations about pets"},{"path":"/user","description":"Operations about user"}],"authorizations":{"oauth2":{"type":"oauth2","scopes":["PUBLIC"],"grantTypes":{"implicit":{"loginEndpoint":{"url":"http://localhost:8002/oauth/dialog"},"tokenName":"access_code"},"authorization_code":{"tokenRequestEndpoint":{"url":"http://localhost:8002/oauth/requestToken","clientIdName":"client_id","clientSecretName":"client_secret"},"tokenEndpoint":{"url":"http://localhost:8002/oauth/token","tokenName":"access_code"}}}},"apiKey":{"type":"apiKey","passAs":"header"}},"info":{"title":"Swagger Sample App","description":"This is a sample server Petstore server.  You can find out more about Swagger \\n    at <a href=\\\"http://swagger.wordnik.com\\\">http://swagger.wordnik.com</a> or on irc.freenode.net, #swagger.","termsOfServiceUrl":"http://helloreverb.com/terms/","contact":"apiteam@wordnik.com","license":"Apache 2.0","licenseUrl":"http://www.apache.org/licenses/LICENSE-2.0.html"}}'

petChild = '{"apiVersion":"1.0.0","swaggerVersion":"1.2","basePath":"http://petstore.swagger.wordnik.com/api","resourcePath":"/pet","produces":["application/json","application/xml","text/plain","text/html"],"apis":[{"path":"/pet/{petId}","operations":[{"method":"GET","summary":"Find pet by ID","notes":"Returns a pet based on ID","responseClass":"Pet","nickname":"getPetById","produces":["application/json","application/xml"],"authorizations":["oauth2"],"parameters":[{"name":"petId","description":"ID of pet that needs to be fetched","required":true,"allowMultiple":false,"dataType":"string","paramType":"path"}],"responseMessages":[{"code":400,"message":"Invalid ID supplied"},{"code":404,"message":"Pet not found"}]}]},{"path":"/pet/findByStatus","operations":[{"method":"GET","summary":"Finds Pets by status","notes":"Multiple status values can be provided with comma seperated strings","responseClass":"List[Pet]","nickname":"findPetsByStatus","produces":["application/json","application/xml"],"parameters":[{"name":"status","description":"Status values that need to be considered for filter","defaultValue":"available","required":true,"allowMultiple":true,"dataType":"string","allowableValues":{"valueType":"LIST","values":["available","pending","sold"]},"paramType":"query"}],"responseMessages":[{"code":400,"message":"Invalid status value"}]}]},{"path":"/pet/findByTags","operations":[{"method":"GET","summary":"Finds Pets by tags","notes":"Muliple tags can be provided with comma seperated strings. Use tag1, tag2, tag3 for testing.","responseClass":"List[Pet]","nickname":"findPetsByTags","produces":["application/json","application/xml"],"parameters":[{"name":"tags","description":"Tags to filter by","required":true,"allowMultiple":true,"dataType":"string","paramType":"query"}],"responseMessages":[{"code":400,"message":"Invalid tag value"}],"deprecated":"true"}]}],"models":{"Tag":{"id":"Tag","name":"Tag","properties":{"name":{"type":"string","required":false},"id":{"type":"long","required":false}}},"Pet":{"id":"Pet","name":"Pet","properties":{"name":{"type":"string","required":false},"tags":{"type":"List","required":false,"items":{"$ref":"Tag"}},"photoUrls":{"type":"List","required":false,"items":{"type":"string"}},"id":{"type":"long","required":false},"status":{"type":"string","required":false,"description":"pet status in the store","allowableValues":{"valueType":"LIST","values":["available","pending","sold"]}},"category":{"type":"Category","required":false}}},"Category":{"id":"Category","name":"Category","properties":{"name":{"type":"string","required":false},"id":{"type":"long","required":false}}}}}'


petSwagger = new SwaggerDoc 'http://petstore.swagger.wordnik.com/api/api-docs', pet

console.log (doc.href for doc in petSwagger.subdocs())
#console.log petSwagger.subdocs()

petSwagger = new SwaggerDoc 'http://petstore.swagger.wordnik.com/api/api-docs', JSON.parse(pet)

console.log (doc.href for doc in petSwagger.subdocs())



petSwagger = new SwaggerDoc 'http://localhost/api-doc', petChild, true

console.log (doc.href for doc in petSwagger.subdocs())

