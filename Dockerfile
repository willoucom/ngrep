FROM nginx:alpine

ENV URL=http://willou.com/

RUN apk update && apk upgrade && apk add bash ngrep curl dumb-init openssl

RUN openssl req -x509 -nodes -days 365 -subj "/C=CA/ST=QC/O=Company, Inc./CN=ngrep.localhost" -addext "subjectAltName=DNS:ngrep.localhost" -newkey rsa:2048 -keyout /etc/ssl/private/nginx-selfsigned.key -out /etc/ssl/certs/nginx-selfsigned.crt;

EXPOSE 80 443

COPY nginx.conf /etc/nginx/nginx-template.conf
COPY entrypoint.sh /entrypoint.sh

CMD ["/usr/bin/dumb-init", "--",                                                                    \
     "bash", "-c",                                                                                  \
     "/entrypoint.sh"]