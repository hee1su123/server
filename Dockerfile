FROM	debian:buster

ENV	AUTOINDEX on

RUN	apt-get update && apt-get -y install \
	vim \
	wget \
	nginx \
	openssl \
	mariadb-server \
	php-fpm \
	php-mysql \
	php-mbstring
	
# nginx
COPY	srcs/default_* /tmp/

RUN	cp -rp tmp/default_autoindexon /etc/nginx/sites-availabe/default

# openssl
RUN	openssl req -newkey rsa:4096 -days 365 -nodes -x509 -subj "/C = KR/ST=Seoul/O=42Seoul/OU=Yang/CN=localhost" -keyout localhost.dev.key -out localhost.dev.crt
	mv localhost.dev.crt /etc/ssl/certs/
	mv localhost.dev.key /etc/ssl/private/
	chmod 600 /etc/ssl/certs/localhost.dev.crt /etc/ssl/private/localhost.dev.key

# wordpress
RUN	wget https://wordpress.org/latest.tar.gz && \
	tar -xvf latest.tar.gz && \
	mv wordpress /var/www/hmtl/ && \
	chown -R www-data:www-data /var/www/html/wordpress

COPY	srcs/wp-config.php /var/www/html/wordpress

# phpmyadmins
RUN	wget https://files.phpmyadmin.net/phpMyAdmin/5.0.2/phpMyAdmin-5.0.2-all-languages.tar.gz && \
	tar -xvf phpMyAdmin-5.0.2-all-languages.tar.gz &&/
	mv phpMyAdmin-5.0.2-all-languages /var/www/html/phpmyadmin

COPY	srcs/config.inc.php /var/www/html/phpmyadmin/

# port
EXPOSE	80 443

#bash
COPY	srcs/*.sh ./

CMD	bash run.sh
