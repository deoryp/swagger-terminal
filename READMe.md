# Swagger Terminal


## Usage

```
swag http://petstore.swagger.wordnik.com/api/api-docs.json

Downloading http://petstore.swagger.wordnik.com/api/api-docs.json.
[-------------------------------------------------------] 100%

  /user
  /pet
  /store

> use /pet

GET /pet.json/{petId}       -  Find pet by ID
POST /pet.json              -  Add a new pet to the store
PUT /pet.json               - Update an existing pet
GET /pet.json/findByStatus  - Finds Pets by status

> using 

  /user
* /pet
  /store

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

> curl

curl -X GET http://petstore.swagger.wordnik.com/api/pet.json/123

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

>
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
    - content type, default application/json
- curl: give the curl command line for the last command
- describe, info about resources based on current context
    - METHOD URL
    - API_URL 
    
Example, 

```
> show response header

response header = false

> set response header true

response body = true

>
```




