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

Dir_Name_Backup="backup"

COLUMNS=$(tput cols)
space="#######################################"
title="Welcome to VirtualHost Generator"
printf "%*s\n" $(((${#space}+$COLUMNS)/2)) "$space"
printf "%*s\n" $(((${#title}+$COLUMNS)/2)) "$title"
printf "%*s\n" $(((${#space}+$COLUMNS)/2)) "$space"
printf "\n"

read -r -p "Enter project name e.g. 'myproject': " Domain
read -r -p "Subdomain e.g. dev, staging: " Subdomain
read -r -p "TLD e.g. com, org: " Tld
read -r -p "Set alias, leave blank for default $Subdomain.$Domain.$Tld: " Alias
read -r -p "Apache's DocumentRoot please, leave blank for /var/www: " DocumentRoot
read -r -p "IP address for domain, leave blank for 127.0.0.1: " IP

if [ "$DocumentRoot" == "" ]; then
    DocumentRoot="/var/www"
fi

if [ "$IP" == "" ]; then
    IP="127.0.0.1"
fi

if [ "$Alias" == "" ]; then
    ServerAlias="$Subdomain.$Domain.$Tld"
else
    ServerAlias="$Alias"
fi

ServerAdmin="$USER@$Domain"
ServerName="$Subdomain.$Domain.$Tld"

#DocumentRoot="$DocumentRoot/$Domain/$Subdomain"
SitesAvailable="/etc/apache2/sites-available/"

read -r -p "Do you want to proceed? (y/n): " YESNO

if [ "$YESNO" == "y" ]; then

  mkdir -p $DocumentRoot/$Domain.$Tld/$Subdomain/{public_html,$Dir_Name_Backup}
  mkdir -p $DocumentRoot/$Domain.$Tld/$Subdomain/$Dir_Name_Backup/{db,ext,site,media,cred}

cat > "$SitesAvailable$ServerName.conf" <<EOF
<VirtualHost *:80>
  ServerAdmin $ServerAdmin
  ServerName  $ServerName
  ServerAlias $ServerAlias
  DirectoryIndex index.php
  DocumentRoot $DocumentRoot/$Domain.$Tld/$Subdomain/public_html
  <Directory $DocumentRoot/$Domain.$Tld/$Subdomain/public_html>
    Options Indexes FollowSymLinks MultiViews
    AllowOverride All
    Require all granted
  </Directory>
  ErrorLog /var/log/apache2/$Domain.$Subdomain.$Tld.error.log
  CustomLog /var/log/apache2/$Domain.$Subdomain.$Tld.access.log combined
</VirtualHost>
EOF
  chown -R "$SUDOING_USER":"$SUDOING_USER" $DocumentRoot/$Domain.$Tld
  echo "$IP $Subdomain.$Domain.$Tld $ServerAlias" >> /etc/hosts
  a2ensite "$ServerName.conf"
  service apache2 restart

  echo "Done ..."
  echo "DocumentRoot is $DocumentRoot/$Domain/$Subdomain/public_html"
  echo "URL is $Subdomain.$Domain.$Tld (Alias $ServerAlias)"
  echo "Thank you :) ba bye!"
else
    echo "Terminated by YOU ;) ... ba bye!"
fi

