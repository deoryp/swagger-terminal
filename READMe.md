# Swagger Terminal


## Usage

```
swag http://petstore.swagger.wordnik.com/api/api-docs.json

Downloading http://petstore.swagger.wordnik.com/api/api-docs.json.
[-------------------------------------------------------] 100%

/user
/pet
/store

> use pet

GET /pet.json/{petId}       -  Find pet by ID
POST /pet.json              -  Add a new pet to the store
PUT /pet.json               - Update an existing pet
GET /pet.json/findByStatus  - Finds Pets by status

> GET /pet.json/123



```

### Commands:

- show
    - url
    - response
        - code
        - headers
