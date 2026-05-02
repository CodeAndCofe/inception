FROM debian:trixie-slim

WORKDIR /app

RUN apt update -y && apt install -y \
    curl \
    php \
    php-fpm \
    php-mysql

RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar

RUN chmod +x wp-cli.phar && mv wp-cli.phar /usr/local/bin/wp

RUN useradd -m app

RUN mkdir -p /var/www/html && chown -R app:app /var/www/html

COPY ./tools/wordPress.sh /app/script.sh

RUN chmod +x /app/script.sh && chown -R app:app /app

RUN sed -i 's|listen = .*|listen = 9000|' /etc/php/*/fpm/pool.d/www.conf

USER app

EXPOSE 9000

ENTRYPOINT [ "/app/script.sh" ]