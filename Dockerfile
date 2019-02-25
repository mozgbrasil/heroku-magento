FROM kstaken/apache2
LABEL name "my-docker-deployment"
RUN apt-get update 
RUN composer install --no-dev
EXPOSE 80
CMD ["/usr/sbin/apache2", "-D", "FOREGROUND"]
