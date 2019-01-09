#!/bin/bash
# Came from https://github.com/adnnor/virtualhost-generator
# @author: Adnan Shahzad
# @Email: adnnor@gmail.com

FILE="$0"
if [ "$EUID" -ne 0 ]; then 
    echo "Run as root e.g. sudo bash ${FILE}"
    exit
fi
SUDOING_USER="${SUDO_USER}"

printf "\n"

COLUMNS=$(tput cols) 
space="#######################################" 
title="Welcome to VirtualHost Generator" 
printf "%*s\n" $(((${#space}+$COLUMNS)/2)) "$space"
printf "%*s\n" $(((${#title}+$COLUMNS)/2)) "$title"
printf "%*s\n" $(((${#space}+$COLUMNS)/2)) "$space"
printf "\n"

read -r -p "Enter project name exluding .tld or subdomain: " Domain
read -r -p "Apache's DocumentRoot please, leave blank for /var/www: " DocumentRoot
read -r -p "IP address for domain, leave blank for 127.0.0.1: " IP

if [ "$DocumentRoot" == "" ]; then
    DocumentRoot="/var/www"
fi

if [ "$IP" == "" ]; then
    IP="127.0.0.1"
fi

ServerAdmin="$USER@$Domain"
ServerName="dev.$Domain.com"
ServerAlias="dev.$Domain.com"
DocumentRoot="$DocumentRoot/$Domain"
SitesAvailable="/etc/apache2/sites-available/"

read -r -p "Do you want to proceed? (y/n): " YESNO

if [ "$YESNO" == "y" ]; then

  mkdir -p $DocumentRoot/{public_html,backup}

cat > "$SitesAvailable$ServerName.conf" <<EOF
<VirtualHost *:80>
  ServerAdmin $ServerAdmin
  ServerName  $ServerName
  ServerAlias $ServerAlias
  DirectoryIndex index.php
  DocumentRoot $DocumentRoot/public_html
  <Directory $DocumentRoot/public_html>
    Options Indexes FollowSymLinks MultiViews
    AllowOverride All
    Require all granted
  </Directory>
  ErrorLog /var/log/apache2/$Domain.error.log
  CustomLog /var/log/apache2/$Domain.access.log combined
</VirtualHost>
EOF
  chown -R "$SUDOING_USER":"$SUDOING_USER" $DocumentRoot
  echo "$IP $Domain $ServerAlias" >> /etc/hosts
  a2ensite "$ServerName.conf"
  service apache2 restart

  echo "Done ..."
  echo "DocumentRoot is $DocumentRoot/public_html"
  echo "URL is $ServerAlias"
  echo "Thank you :) ba bye!"
else
    echo "Terminated by YOU ;) ... ba bye!"
fi

