# Makefile для збирання та тестування коду на різних платформах та архітектурах

# Назва проекту
PROJECT_NAME=myapp

# Базовий образ для Docker
BASE_IMAGE=quay.io/projectquay/golang:1.20

# Функція для збирання бінарного файлу для вказаної платформи та архітектури
build:
	GOOS=$(GOOS) GOARCH=$(GOARCH) go build -o $(PROJECT_NAME)_$(GOOS)_$(GOARCH)

# Цілі для різних платформ та архітектур
linux:
	$(MAKE) build GOOS=linux GOARCH=amd64
	$(MAKE) build GOOS=linux GOARCH=arm64

macos:
	$(MAKE) build GOOS=darwin GOARCH=amd64
	$(MAKE) build GOOS=darwin GOARCH=arm64

windows:
	$(MAKE) build GOOS=windows GOARCH=amd64
	$(MAKE) build GOOS=windows GOARCH=arm64

# Ціль для тестування коду в Docker
docker-test:
	docker build --build-arg GOOS=$(GOOS) --build-arg GOARCH=$(GOARCH) -t $(PROJECT_NAME):$(GOOS)_$(GOARCH) -f Dockerfile .
	docker run --rm $(PROJECT_NAME):$(GOOS)_$(GOARCH)

# Видалення новостворених образів
clean:
	docker rmi $(PROJECT_NAME):linux_amd64 || true
	docker rmi $(PROJECT_NAME):linux_arm64 || true
	docker rmi $(PROJECT_NAME):darwin_amd64 || true
	docker rmi $(PROJECT_NAME):darwin_arm64 || true
	docker rmi $(PROJECT_NAME):windows_amd64 || true
	docker rmi $(PROJECT_NAME):windows_arm64 || true
	rm -f $(PROJECT_NAME)_linux_amd64 $(PROJECT_NAME)_linux_arm64 $(PROJECT_NAME)_darwin_amd64 $(PROJECT_NAME)_darwin_arm64 $(PROJECT_NAME)_windows_amd64.exe $(PROJECT_NAME)_windows_arm64.exe

.PHONY: build linux macos windows docker-test clean
