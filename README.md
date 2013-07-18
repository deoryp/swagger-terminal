# Swagger Terminal

Documentation of intended usage. Future plans. 

## Usage

### swagger

```
swagger http://petstore.swagger.wordnik.com/api/api-docs.json

Downloading http://petstore.swagger.wordnik.com/api/api-docs.json.
[-------------------------------------------------------] 100%

  /user
  /pet
  /store
```

###use, using

```
> use /pet

GET  /pet.json/{petId}       -  Find pet by ID
POST /pet.json               -  Add a new pet to the store
PUT  /pet.json               - Update an existing pet
GET  /pet.json/findByStatus  - Finds Pets by status

> using 

  /user
* /pet
  /store
```
###GET

```
> GET /pet.json/123

GETTING http://petstore.swagger.wordnik.com/api/pet.json/123
Response Body: 
{
  "id": 123,
  "category": {
    "id": 123,
    "name": "dog"
  },
  "name": "tonka",
  "photoUrls": [
    ""
  ],
  "tags": [
    {
      "id": 123,
      "name": "test"
    }
  ],
  "status": "sold"
}
Response Code: 200
```

###curl

```
> curl

curl -X GET http://petstore.swagger.wordnik.com/api/pet.json/123
```

###describe

```
> describe POST /pet.json

Description: Returns a pet based on ID
Url: GET http://petstore.swagger.wordnik.com/api/pet.json
Url Parameters:
Body Parameters:
{
  "tags": [
    {
      "id": "long",
      "name": "string"
    }
  ],
  "id": "long",
  "category": {
    "id": "long",
    "name": "string"
  },
  "status": "string",
  "name": "string",
  "photoUrls": [
    "string"
  ]
}
```

###POST


```
> POST /pet.json
```

Then in your defined editor,

```
{
  "tags": [
    {
      "id": "long",
      "name": "string"
    }
  ],
  "id": "long",
  "category": {
    "id": "long",
    "name": "string"
  },
  "status": "string",
  "name": "string",
  "photoUrls": [
    "string"
  ]
}
~                                                                                                                                                                 
~                                                                                                                                                                 
~                                                                                                                                                                 
"/tmp/tmptmp" 18L, 228C
```

Save and exit, 

```
POSTING http://petstore.swagger.wordnik.com/api/pet.json, with request Body: 
{
  "tags": [
    {
      "id": 123,
      "name": "test"
    }
  ],
  "id": 123,
  "category": {
    "id": 123,
    "name": "dog"
  },
  "name": "tonka",
  "status": "sold",
    "photoUrls": [
    ""
  ]
}

.... DONE.

Response Body: 
SUCCESS
Response Code: 200
 
>
 
```

###history

```
> history
 1  swagger http://petstore.swagger.wordnik.com/api/api-docs.json
 2  use /pet
 3  GET /pet.json/123 
 4  curl 
 5  describe POST /pet.json
 6  POST /pet.json
 7  history
> !3
GET /pet.json/123 
GETTING http://petstore.swagger.wordnik.com/api/pet.json/123
<etc> 

```


### Commands:

- use API_URL
- done
- using, use: show the current API in use.
- show, set: Property getting/settings.
    - url, default true
    - response
        - body
        - code, default true
        - headers, default false
    - curl, default false
    - .{format}, default json
    - content type, default application/json
- curl: give the curl command line for the last command
- describe, info about resources based on current context
    - METHOD URL
    - API_URL 
    
### show, set

```
> show response body

response body = false

> set response body true

response body = true

>
```




