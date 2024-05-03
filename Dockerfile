FROM golang:1.20.14 AS builder

# Копіюємо код у робочу директорію
WORKDIR /app
COPY . .

# Збираємо код для Linux/AMD64
RUN GOOS=linux GOARCH=amd64 go build -o myapp_linux_amd64 .

# Збираємо код для Linux/ARM64
RUN GOOS=linux GOARCH=arm64 go build -o myapp_linux_arm64 .

# Збираємо код для macOS/AMD64
RUN GOOS=darwin GOARCH=amd64 go build -o myapp_darwin_amd64 .

# Збираємо код для Windows/AMD64
RUN GOOS=windows GOARCH=amd64 go build -o myapp_windows_amd64.exe .

# Фінальний образ
FROM alpine:latest

# Додаємо бінарні файли зі збірки
COPY --from=builder /app/myapp_linux_amd64 /app/myapp_linux_arm64 /app/myapp_darwin_amd64 /app/myapp_windows_amd64.exe /app/

# Команда за замовчуванням
CMD ["./myapp_linux_amd64"]
