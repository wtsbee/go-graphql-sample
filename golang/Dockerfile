FROM golang:1.19.1-alpine

WORKDIR /go/src

RUN apk update && apk add git

RUN apk add --no-cache gcc && apk add --no-cache musl-dev

RUN go install github.com/99designs/gqlgen@latest
RUN go install github.com/volatiletech/sqlboiler/v4@latest
RUN go install github.com/volatiletech/sqlboiler/v4/drivers/sqlboiler-mysql@latest
