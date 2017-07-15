#!/bin/bash

echo "Serving docs on localhost:8081"
docker run -p 8081:8080 -e "SWAGGER_JSON=/code/service.swagger.json" -v $(pwd)/gen:/code:ro swaggerapi/swagger-ui
