#!/bin/bash

LOG_DIRECTORY='/tmp'

ADMIN_USER='mysqladmin@wso2eidb'
ADMIN_PASSWORD='${db_admin_password}'
CONNECTION_STRING='${db_connection_strings}'
DB_HOME='/tmp/dbscripts'
USER_PASSWORD="BEstr11ng_#12"

mysql <<EOF  > $LOG_DIRECTORY/query.log -h $CONNECTION_STRING -u mysqladmin@wso2eidb -p$ADMIN_PASSWORD

CREATE DATABASE gov_db;
CREATE USER gov_user IDENTIFIED BY "$USER_PASSWORD";
GRANT ALL ON gov_db.* TO gov_user@'%' IDENTIFIED BY "$USER_PASSWORD";

CREATE DATABASE shared_db;
CREATE USER shared_user IDENTIFIED BY "$USER_PASSWORD";
GRANT ALL ON shared_db.* TO shared_user@'%' IDENTIFIED BY "$USER_PASSWORD";

FLUSH PRIVILEGES;
EOF

mysql -s  <<EOF  > $LOG_DIRECTORY/query.log -h $CONNECTION_STRING -u gov_user@wso2eidb -p$USER_PASSWORD

USE gov_db;
SOURCE $DB_HOME/mysql.sql

EOF

mysql -s  <<EOF  > $LOG_DIRECTORY/query.log -h $CONNECTION_STRING -u shared_user@wso2eidb -p$USER_PASSWORD

USE shared_db;
SOURCE $DB_HOME/mysql.sql

EOF
