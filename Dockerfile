FROM golang:1.22.5 as base

WORKDIR /app

COPY go.mod .

RUN go mod download

COPY . .

RUN GOOS=linux GOARCH=arm64 go build -o main .

FROM gcr.io/distroless/base

COPY --from=base /app/main ./main

COPY --from=base /app/static ./static

EXPOSE 8080

CMD ["./main"]