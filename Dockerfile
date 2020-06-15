FROM nginx:alpine

COPY nginx.conf /etc/nginx/nginx-template.conf

RUN apk update && apk upgrade && apk add bash ngrep curl dumb-init openssl

RUN openssl req -x509 -nodes -days 365 -subj "/C=CA/ST=QC/O=Company, Inc./CN=ngrep.localhost" -addext "subjectAltName=DNS:ngrep.localhost" -newkey rsa:2048 -keyout /etc/ssl/private/nginx-selfsigned.key -out /etc/ssl/certs/nginx-selfsigned.crt;

EXPOSE 80 443

CMD ["/usr/bin/dumb-init", "--",                                                                    \
     "bash", "-c",                                                                                  \
     "envsubst < /etc/nginx/nginx-template.conf > /etc/nginx/nginx.conf && nginx -g 'daemon off;'"]