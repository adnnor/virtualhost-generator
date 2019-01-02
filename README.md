# VirtualHost Generator

This bash script will help you to generate VirtualHost for Ubuntu 16.04 LTS (Xenial Xerus) and Ubuntu 18.04 LTS (Bionic Beaver)

## Usage
- Clone the repository
- Open terminal and run
```bash
sudo bash vhgen.sh
```
Following is output of the script
```bash

                              #######################################
                                  Welcome to VirtualHost Generator
                              #######################################

Enter project name exluding .tld or subdomain: testing
Apache's DocumentRoot please, leave blank for /var/www: 
IP address for domain, leave blank for 127.0.0.1: 
Do you want to proceed? (y/n): y
Enabling site dev.testing2.com.
To activate the new configuration, you need to run:
  systemctl reload apache2
Done ...
DocumentRoot is /var/www/testing2/public_html
URL is dev.testing2.com
Thank you :) ba bye!
```

> **DISCALIMER:** These instructions are made available for ease and not recommended for the production, owner will not be responsible of any damage or lose of data or whatsoever.
