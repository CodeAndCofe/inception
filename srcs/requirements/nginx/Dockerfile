FROM debian:trixie-backports

WORKDIR /app

RUN apt update -y && \
    apt install -y nginx && \
    rm -rf /var/lib/apt/lists/*

COPY ./tools/script.sh ./entrypoint.sh
COPY ./conf/ngx.cnf /etc/nginx/conf.d/default.conf

RUN chmod +x /usr/local/bin/entrypoint.sh

EXPOSE 443

ENTRYPOINT ["entrypoint.sh"]
CMD ["nginx", "-g", "daemon off;"]