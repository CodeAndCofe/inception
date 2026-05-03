FROM debian:trixie-slim

WORKDIR /app

RUN apt update -y && apt install -y \
    curl \
    php \
    php-fpm \
    php-mysql \
    default-mysql-client \
    && rm -rf /var/lib/apt/lists/*

RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar \
    && chmod +x wp-cli.phar \
    && mv wp-cli.phar /usr/local/bin/wp


# IMPORTANT: runtime directory for PHP-FPM
RUN mkdir -p /run/php

COPY ./tools/wordPress.sh /app/script.sh
RUN chmod +x /app/script.sh

# Only needed change
RUN sed -i 's|listen = .*|listen = 9000|' /etc/php/*/fpm/pool.d/www.conf
RUN sed -i 's|;clear_env = no|clear_env = no|' /etc/php/*/fpm/pool.d/www.conf

EXPOSE 9000

ENTRYPOINT ["/app/script.sh"]