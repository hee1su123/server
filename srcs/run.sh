#!/bin.bash

if [ "$AUTOINDEX" = "off" ];
then cp -rp /tmp/default_autoindexoff /etc/nginx/sites-available/default;fi

service php7.3-fpm start
service mysql start
echo "CREATE DATABASE IF NOT EXISTS wordpress;" | mysql -u root --skip-password
echo "CREATE USER IF NOT EXISTS 'heeyang'@'localhost' identified by 'heeyang';" | mysql -u root --skip-password
echo "GRANT ALL PRIVILEGES ON wordpress.* TO 'heeyang'@'localhost' WITH GRANT OPTION;" | mysql -u root --skip-password
service nginx start
service mysql restart
service php7.3-fpm restart
