FROM	debian:trixie-slim



RUN apt update -y && apt install nginx -y && apt install openssl -y


RUN openssl req -x509 -newkey rsa:4096 -days 3650 \
    -noenc -keyout private.key -out certificate.crt -subj "/CN=Morocco.com" \


EXPOSE 443




