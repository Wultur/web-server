FROM ubuntu/nginx:1.18-20.04_beta

RUN mkdir -p /etc/letsencrypt/live \
    && rm /etc/nginx/sites-enabled/default \
    && rm /etc/nginx/sites-available/default

COPY ./certs/ /etc/letsencrypt/live/

COPY ./conf/ /etc/nginx/sites-available/

RUN ln -s /etc/nginx/sites-available/* /etc/nginx/sites-enabled/