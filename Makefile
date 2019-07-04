BASEPATH=github.com/vvb/grpc-demo
default: build

api/api.pb.go: api/api.proto
	protoc -I api/ -I${GOPATH}/src --go_out=plugins=grpc:api api/api.proto

bin/server: api/api.pb.go server/main.go
	go build -i -v -o bin/server $(BASEPATH)/server

bin/client: api/api.pb.go client/main.go
	go build -i -v -o bin/client $(BASEPATH)/client

build: bin/client bin/server

clean:
	rm -rf bin api/api.pb.go

.PHONY: build clean
