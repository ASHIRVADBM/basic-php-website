FROM ubuntu:20.04

ARG DEBIAN_FRONTEND=noninteractive

RUN sed -i 's|http://archive.ubuntu.com/|http://us.archive.ubuntu.com/|g' \
    /etc/apt/sources.list

RUN apt-get update -y && \
    apt-get install -y apache2 php libapache2-mod-php && \
    apt-get clean

COPY 000-default.conf /etc/apache2/sites-available/000-default.conf

COPY . /var/www/html/

RUN chown -R www-data:www-data /var/www/html/

EXPOSE 80

ENTRYPOINT ["apachectl", "-D", "FOREGROUND"]
