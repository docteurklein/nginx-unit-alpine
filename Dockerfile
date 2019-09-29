FROM alpine:edge as build
    RUN apk add --no-cache unit-php7 curl
    COPY config.json .
    RUN unitd && curl -X PUT http://localhost/config --data-binary @config.json --unix-socket /run/control.unit.sock

FROM alpine:edge
    RUN apk add --no-cache unit-php7
    ENTRYPOINT ["unitd", "--no-daemon", "--log", "/dev/stderr"]
    COPY --from=build /var/lib/unit /var/lib/unit
    COPY app /app
