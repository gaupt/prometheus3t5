OUTPUT_DIR := build
GO_SOURCES := $(wildcard *.go)
IMAGE_TAG := week3go

linux: $(GO_SOURCES)
	GOOS=linux GOARCH=amd64 go build -o $(OUTPUT_DIR)/linux_amd64 ./...

arm: $(GO_SOURCES)
	GOOS=linux GOARCH=arm64 go build -o $(OUTPUT_DIR)/linux_arm64 ./...

macos: $(GO_SOURCES)
	GOOS=darwin GOARCH=amd64 go build -o $(OUTPUT_DIR)/darwin_amd64 ./...

windows: $(GO_SOURCES)
	GOOS=windows GOARCH=amd64 go build -o $(OUTPUT_DIR)/windows_amd64.exe ./...

all: linux arm macos windows

clean:
	rm -rf $(OUTPUT_DIR)
	docker rmi $(IMAGE_TAG)
