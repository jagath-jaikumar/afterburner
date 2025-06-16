# Use an official Golang image as the builder
FROM golang:1.24.4 AS builder

# Set the working directory inside the container
WORKDIR /app

# Copy go.mod and go.sum files
COPY go.mod ./
COPY go.sum ./

# Download all dependencies. Dependencies will be cached if the go.mod and go.sum files are not changed
RUN go mod download

# Copy the source code into the container
COPY . .

# Build the binaries for all commands
RUN go build -o /app/bin/api ./cmd/api/main.go
RUN go build -o /app/bin/worker ./cmd/worker/main.go
RUN go build -o /app/bin/listener ./cmd/listener/main.go

# Use a minimal base image for the final image
FROM alpine:latest

# Set the working directory inside the container
WORKDIR /app

# Copy the binaries from the builder
COPY --from=builder /app/bin /app/bin

RUN chmod +x /app/bin/*

# Default command (can be overridden at runtime)
CMD ["/app/bin/listener"]



