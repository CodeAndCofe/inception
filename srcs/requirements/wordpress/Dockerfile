FROM debian:trixie-backports


WORKDIR /app


RUN apt update -y
COPY    ./tools .

RUN apt install  -r ./tools/requirement.txt -y

RUN rm -rf /var/lib/apt/lists/*

RUN wget https://wordpress.org/latest.tar.gz && \
    tar -xzf latest.tar.gz && \
    mv wordpress/* /var/www/html/ && \
    rm -rf latest.tar.gz wordpress

RUN chown -R www-data:www-data /var/www/html && \
    chmod -R 755 /var/www/html

RUN chmod +x ./tools/script.sh
