#!/bin/bash

#== If webRoot has not been difined, we will set appRoot to webRoot
if [[ ! -n "$WEB_ROOT" ]]; then
  WEB_ROOT=$APP_ROOT
fi

STATIC_FILES_PATH="$WEB_ROOT/sites/default/files/";

#Create static directory
if [ ! -d "$STATIC_PATH" ]; then
  mkdir -p $STATIC_FILES_PATH;
fi;

#== Extract static files
if [[ -f "$APP_ROOT/.devpanel/dumps/files.tgz" ]]; then
  tar xzf "$APP_ROOT/.devpanel/dumps/files.tgz" -C $STATIC_FILES_PATH;
fi
#== Import mysql files
if [[ -f "$APP_ROOT/.devpanel/dumps/db.sql.tgz" ]]; then
  SQLFILE=$(tar tzf $APP_ROOT/.devpanel/dumps/db.sql.tgz)
  tar xzf "$APP_ROOT/.devpanel/dumps/db.sql.tgz" -C /tmp/
  mysql -h$DB_HOST -u$DB_USER -p$DB_PASSWORD $DB_NAME < /tmp/$SQLFILE
  rm /tmp/$SQLFILE
fi

#== Create settings files
cp $APP_ROOT/.devpanel/drupal7-settings.php $WEB_ROOT/sites/default/settings.php;

#== Config permission
cd $WEB_ROOT;
find sites themes modules profiles -type f -exec chmod g+w {} +;
find sites themes modules profiles -type d -exec chmod g+ws {} +;

chown -R 1000:82 $APP_ROOT/;