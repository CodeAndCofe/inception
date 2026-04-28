FROM debian:trixie-slim

WORKDIR /app

RUN apt update -y && apt install curl -y


COPY ./tools/wordPress.sh /app/script.sh

EXPOSE 443

