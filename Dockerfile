# Використовуємо базовий образ quay.io/projectquay/golang:1.20
FROM quay.io/projectquay/golang:1.20 AS builder

# Аргументи для платформи та архітектури
ARG GOOS
ARG GOARCH

# Копіюємо код у робочу директорію
WORKDIR /app
COPY . .

# Збираємо код для вказаної платформи та архітектури
RUN GOOS=${GOOS} GOARCH=${GOARCH} go build -o myapp .

# Фінальний образ для тестування
FROM quay.io/projectquay/golang:1.20

# Копіюємо бінарний файл зі збірки
COPY --from=builder /app/myapp /app/myapp

# Налаштування змінної середовища для ОС та архітектури
ENV GOOS=${GOOS}
ENV GOARCH=${GOARCH}

# Запускаємо бінарний файл за замовчуванням
CMD ["/app/myapp"]
