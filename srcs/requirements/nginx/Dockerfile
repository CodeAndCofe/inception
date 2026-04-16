FROM debian:trixie-backports

WORKDIR /app

RUN apt update -y && \
    apt install -y nginx openssl && \
    rm -rf /var/lib/apt/lists/*

RUN mkdir -p /etc/nginx/ssl && \
    openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
    -keyout /etc/nginx/ssl/inception.key \
    -out /etc/nginx/ssl/inception.crt \
    -subj "/C=MA/ST=Khouribga/L=Khouribga/O=1337/CN=aferryat.42.fr"

#  x509 requset to create self signed certificate with -x509 formate (spoiler there many other formate but this is standart and most used in applications like http and vpn etc)
# other signed formate is PEM base 64 text formate

COPY ./conf/ngx.cnf /etc/nginx/conf.d/default.conf
COPY ./tools/script.sh /usr/local/bin/entrypoint.sh

RUN chmod +x /usr/local/bin/entrypoint.sh

EXPOSE 443

ENTRYPOINT ["entrypoint.sh"]
CMD ["nginx", "-g", "daemon off;"]