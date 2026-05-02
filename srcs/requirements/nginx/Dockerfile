FROM debian:trixie-slim

WORKDIR /app

RUN apt update -y && apt install nginx openssl -y \
    && rm -rf /var/lib/apt/lists/*

COPY ./conf/*.cnf /etc/nginx/conf.d/

RUN mkdir -p /etc/nginx/ssl

RUN openssl req -x509 -newkey rsa:4096 -days 3650 \
    -nodes -keyout /etc/nginx/ssl/inception.key \
    -out /etc/nginx/ssl/inception.crt \
    -subj "/CN=aferryat.42.fr"

COPY ./tools/script.sh /app/tool.sh
RUN chmod +x /app/tool.sh

EXPOSE 443

ENTRYPOINT ["/app/tool.sh"]
CMD ["nginx", "-g", "daemon off;"]