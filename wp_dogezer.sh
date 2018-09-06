#!/bin/bash
cp /bitnami/wordpress/wp-config.php /opt/bitnami/wordpress/wp-config.php.old
FILTER_LINE=$(expr $(grep -n -m 1 add_filter /bitnami/wordpress/wp-config.php  | cut -d':' -f1) - 1)
head -$FILTER_LINE /opt/bitnami/wordpress/wp-config.php.old > /bitnami/wordpress/wp-config.php
#head -103 /opt/bitnami/wordpress/wp-config.php.old > /bitnami/wordpress/wp-config.php
curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
chmod +x wp-cli.phar
mv wp-cli.phar /usr/local/bin/wp
wp cli update
wp plugin activate wp-static-html-output --allow-root --path=/opt/bitnami/wordpress/
wp plugin activate static-html-output-plugin --allow-root --path=/opt/bitnami/wordpress/
chmod -R 0777 /opt/bitnami/wordpress/wp-content/uploads
chmod -R 0777 /opt/bitnami/wordpress/wp-content/uploads/