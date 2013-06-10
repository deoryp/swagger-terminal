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

> describe POST /pet.json

Url: GET http://petstore.swagger.wordnik.com/api/pet.json/123

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

### Commands:

- show, set
    - url, default true
    - response
        - body
        - code, default true
        - headers, default false
    - curl, default false
    - content type, default application/json
- curl, give the curl command line for the last command


Example, 

```
> show response header
response header = false
> set response header true
response body = true
```




