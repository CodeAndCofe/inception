FROM debian:trixie-slim

WORKDIR /app

RUN apt update -y && apt install -y curl  php less  php-fpm

RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar

RUN chmod +x wp-cli.phar
RUN mv wp-cli.phar /usr/local/bin/WP
RUN useradd -m app

COPY ./tools/wordPress.sh /app/script.sh

RUN chmod +x script.sh
RUN chown -R app:app /app
RUN chown -R app:app /var/www/html

USER app

EXPOSE 9000


ENTRYPOINT [ "script.sh" ]