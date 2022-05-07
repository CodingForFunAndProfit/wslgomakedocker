# syntax=docker/dockerfile:1

##
## Build
##
FROM golang:1.18-alpine AS build

WORKDIR /

COPY go.* ./
RUN go mod download

COPY *.go ./

RUN go build -o /hello .

##
## Deploy
##
FROM gcr.io/distroless/base-debian10

WORKDIR /

COPY --from=build /hello /hello

USER nonroot:nonroot

ENTRYPOINT ["/hello"]
