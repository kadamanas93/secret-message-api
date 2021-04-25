FROM golang:alpine AS builder

WORKDIR /build

COPY go.mod .
COPY go.sum .
RUN go mod download

COPY . .

RUN CGO_ENABLED=0 GOOS=linux go build -o main .


FROM scratch
COPY --from=builder /build/main /
ENTRYPOINT ["/main"]
