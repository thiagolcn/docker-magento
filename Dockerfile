FROM occitech/magento:php5.5-apache

ENV MAGENTO_VERSION 1.9.2.4

RUN apt-get update && apt-get install -y mysql-client-5.5 libxml2-dev git vim
RUN docker-php-ext-install soap

COPY ./bin/checkout-magento /usr/local/bin/checkout-magento
RUN chmod +x /usr/local/bin/checkout-magento

COPY ./bin/install-magento /usr/local/bin/install-magento
RUN chmod +x /usr/local/bin/install-magento

COPY ./bin/install-magento /usr/local/bin/checkout-personalizador
RUN chmod +x /usr/local/bin/checkout-personalizador

COPY ./bin/install-magento /usr/local/bin/install-all
RUN chmod +x /usr/local/bin/install-all

COPY ./sampledata/magento-sample-data-1.9.1.0.tgz /opt/
COPY ./bin/install-sampledata-1.9 /usr/local/bin/install-sampledata
RUN chmod +x /usr/local/bin/install-sampledata

RUN bash -c 'bash < <(curl -s -L https://raw.github.com/colinmollenhour/modman/master/modman-installer)'
RUN mv ~/bin/modman /usr/local/bin

VOLUME /var/www/htdocs
RUN sed -i 's/DocumentRoot \/var\/www\/html/DocumentRoot \/var\/www\/htdocs/' /etc/apache2/sites-available/000-default.conf
RUN sed -i 's/DocumentRoot \/var\/www\/html/DocumentRoot \/var\/www\/htdocs/' /etc/apache2/sites-available/default-ssl.conf

#COPY redis.conf /var/www/htdocs/app/etc/