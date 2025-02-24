FROM golang:1.23.2 as build

WORKDIR /go/src/app
COPY . .

RUN go mod download

RUN CGO_ENABLED=0 go build -o /go/bin/app

FROM alpine

COPY --from=build /go/bin/app /
CMD ["/app"]
