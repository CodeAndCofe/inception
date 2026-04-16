FROM debian:trixie-backports

WORKDIR /var/www/html

RUN apt update && apt install -y \
    php-fpm \
    php-mysql \
    php-curl \
    php-gd \
    php-mbstring \
    php-xml \
    php-zip \
    php-exif \
    wget \
    curl \
    && rm -rf /var/lib/apt/lists/*

COPY ./tools .

RUN wget https://wordpress.org/latest.tar.gz && \
    tar -xzf latest.tar.gz && \
    mkdir -p /var/www/html && \
    mv wordpress/* /var/www/html/ && \
    rm -rf latest.tar.gz wordpress

RUN chown -R www-data:www-data /var/www/html && \
    chmod -R 755 /var/www/html


# CMD ["php-fpm8.4", "-F", "-R"]