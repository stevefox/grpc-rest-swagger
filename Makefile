# The MIT License
#
# Copyright (c) 2017 Stephen Fox, http://www.stevefox.io
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
# THE SOFTWARE.


GOPATH = gopath
PROTOS = $(wildcard src/proto/*.proto)
GENDIR = gen
PROTOC = python3 -m grpc_tools.protoc
PROTO_SRC = src/proto
SWAGGER_OUT = $(GENDIR)

OUTDIRS = $(GENDIR)/go $(GENDIR)/python
export PATH := $(PATH):$(GOPATH)/bin

all : swagger python go gateway

prebuild:
	mkdir -p $(OUTDIRS)

swagger: prebuild $(PROTOS)
	$(PROTOC) -I$(PROTO_SRC) \
	-I$(GOPATH)/src \
	-I$(GOPATH)/src/github.com/grpc-ecosystem/grpc-gateway/third_party/googleapis \
	--swagger_out=logtostderr=true:$(SWAGGER_OUT) \
	$(PROTOS)

python: prebuild $(PROTOS)
	$(PROTOC) \
	-I$(PROTO_SRC) \
	-I$(GOPATH)/src/github.com/grpc-ecosystem/grpc-gateway/third_party/googleapis \
	--python_out=$(GENDIR)/python/ \
	--grpc_python_out=$(GENDIR)/python/ \
	$(PROTOS)

go: prebuild $(PROTOS)
	$(PROTOC) -I$(PROTO_SRC) \
	  -I$(GOPATH)/src \
	  -I$(GOPATH)/src/github.com/grpc-ecosystem/grpc-gateway/third_party/googleapis \
	  --go_out=plugins=grpc:$(GENDIR)/go \
	$(PROTOS)

gateway: go python $(PROTOS)
	$(PROTOC) \
	  -I$(PROTO_SRC) \
	  -I$(GOPATH)/src \
	  -I$(GOPATH)/src/github.com/grpc-ecosystem/grpc-gateway/third_party/googleapis \
	  --grpc-gateway_out=logtostderr=true:${GENDIR}/go/ \
	$(PROTOS)

.PHONY: clean
clean:
	rm -rf $(GENDIR)

.PHONY: default
default: all
