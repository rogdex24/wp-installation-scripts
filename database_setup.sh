#!/bin/bash

# Retrieve the parameter values
DB_HOST=$(aws ssm get-parameter --name "/myapp/DB_HOST" --query "Parameter.Value" --output text)
DB_USER=$(aws ssm get-parameter --name "/myapp/DB_USER" --with-decryption --query "Parameter.Value" --output text)
DB_PASSWORD=$(aws ssm get-parameter --name "/myapp/DB_PASSWORD" --with-decryption --query "Parameter.Value" --output text)
DB_NAME=$(aws ssm get-parameter --name "/myapp/DB_NAME" --query "Parameter.Value" --output text)
DB_NEWUSER=$(aws ssm get-parameter --name "/myapp/DB_NEWUSER" --with-decryption --query "Parameter.Value" --output text)
DB_NEWPASSWORD=$(aws ssm get-parameter --name "/myapp/DB_NEWPASSWORD" --with-decryption --query "Parameter.Value" --output text)


# MySQL setup script
mysql -h "${DB_HOST}" -u "${DB_USER}" -p"${DB_PASSWORD}" <<EOF
CREATE DATABASE ${DB_NAME};

CREATE USER '${DB_NEWUSER}'@'%' IDENTIFIED BY '${DB_NEWPASSWORD}';

GRANT ALL PRIVILEGES ON ${DB_NAME}.* TO '${DB_NEWUSER}'@'%';

FLUSH PRIVILEGES;

EXIT;
EOF
