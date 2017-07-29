This is an experiment for writing gRPC services that can be easily exposed as HTTP/2 compatible REST interfaces. They also have built-in validation and the entire [Swagger Tools ecosystem](https://swagger.io/tools/).

This is a great design pattern if you want to gRPC for most of your APIs, but still expose an HTTP API (for example, to make it easier for javascript clients to consume an API).

# Set up

1. Install swagger extras (`goget.sh`)
2. Write the `service.proto` using `import "google/api/annotations.proto";`
3. Compile your services to the target language
   - Known issue generating python services https://github.com/grpc/grpc/issues/4961
4. Install `go` depedencies:
   - `export GOPATH=$(pwd)/gopath`
   - go get .` to install dependencies in main.go

# To Run the Services:

1. Start the proxy gateway
   - `go run main.go`
2. Run the python server and client:
   - Add the generated python code to your python path
     - `export PYTHONPATH=gen/python`
   - Start the backend gRPC service
     - python3 service_impl.py
   - Run the gRPC client
     - `python3 service_client.py` which accesses the backend gRPC service directly
3. Access via HTTP
   - `curl -X POST -H "Content-Type: application/json" "http://localhost:50052/v1/example/echo" -d '{}'`

# See the Swagger Docs (using Docker)
 - Run `./docs.sh`, which starts a docker container for swagger-ui

# Generate HTTP client libraries using Swgager
- mkdir -p gen/swagger_gen/python
- `docker pull swaggerapi/swagger-codegen-cli`
- `docker run --user ${UID} -v $(pwd)/gen:/local swaggerapi/swagger-codegen-cli generate -i /local/service.swagger.json -l python -o /local/swagger_gen/python`

## Using Swagger client libraries

Swagger Codegen generates documentation and usage examples. See `gen/swagger_gen/python/README.md` for automatically generated client documentation.
