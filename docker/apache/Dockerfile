FROM ubuntu/apache2:2.4-20.04_beta

COPY apache.gotdns.ch.conf /etc/apache2/sites-available/apache.gotdns.ch.conf

COPY ports.conf /etc/apache2/ports.conf

RUN a2enmod actions && a2enmod proxy_fcgi && a2dissite 000-default && a2ensite apache.gotdns.ch

EXPOSE 8080