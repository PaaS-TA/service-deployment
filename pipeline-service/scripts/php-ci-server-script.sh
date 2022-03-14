#!/bin/bash
chmod 777 /var/tmp
apt-get install -y software-properties-common
add-apt-repository -y ppa:ondrej/php
apt-get update -y
apt-get install -y php7.4
apt-get install -y php7.4-{curl,gd,mbstring,soap,json,intl,zip,xml,xmlrpc,cli,xsl}

wget https://buildpacks.cloudfoundry.org/dependencies/composer/composer_2.1.14_linux_noarch_any-stack_d44a9045.phar
mv composer_2.1.14_linux_noarch_any-stack_d44a9045.phar /usr/local/bin/composer.phar
chmod +x /usr/local/bin/composer.phar
ln -s /usr/local/bin/composer.phar /usr/local/bin/composer
export COMPOSER_ALLOW_SUPERUSER=1
chmod o-w /var/tmp
composer --version

echo 'php, composer module install complete'