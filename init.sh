#!/bin/bash

#== If webRoot has not been difined, we will set appRoot to webRoot
if [[ ! -n "$WEB_ROOT" ]]; then
  WEB_ROOT=$APP_ROOT
fi

#== Create settings files
cp $APP_ROOT/.devpanel/drupal7-settings.php $WEB_ROOT/sites/default/settings.php;

#== Use Drush to create site installed
drush -y site-install standard --account-name=$DRUPAL7_ADMIN --account-pass=$DRUPAL7_ADMINPWD --db-url=mysql://$DB_USER:$DB_PASSWORD@$DB_HOST:$DB_PORT/$DB_NAME;

#== Config permission
cd $WEB_ROOT;
find sites themes modules profiles -type f -exec chmod g+w {} +;
find sites themes modules profiles -type d -exec chmod g+ws {} +;

chown -R 1000:82 $APP_ROOT/;