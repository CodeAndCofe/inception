FROM debian:trixie-slim

WORKDIR /app

RUN apt update -y && apt install -y curl  php less

RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar


RUN useradd -m appuser
COPY ./tools/wordPress.sh /app/script.sh

RUN chown -R appuser:appuser /app

USER appuser

EXPOSE 443


ENTRYPOINT [ "script.sh" ]