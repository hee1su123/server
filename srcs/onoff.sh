#!/binbash

if [ "$AUTOINDEX" = "off" ];
then cp /tmp/default_autoindexoff /etc/nginx/sites-available/default;
else cp /tmp/default_autoindexon /etc/nginx/sites-available/default;fi
service nginx reload
