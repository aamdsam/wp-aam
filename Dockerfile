FROM wordpress:latest

ENV WORDPRESS_DB_HOST=mysql.default.svc.cluster.local \
    WORDPRESS_DB_USER=mysql_user \
    WORDPRESS_DB_PASSWORD=mysql_pass \
    WORDPRESS_DB_NAME=db_wp_aam

COPY ./wordpress /var/www/html

RUN chown -R www-data:www-data /var/www/html \
    && chmod -R 755 /var/www/html

EXPOSE 80 443

CMD ["apache2-foreground"]