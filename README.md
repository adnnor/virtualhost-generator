# VirtualHost Generator

This bash script will help you to generate VirtualHost for Ubuntu 16.04 LTS (Xenial Xerus) and Ubuntu 18.04 LTS (Bionic Beaver)

## Usage
```bash
$ wget https://raw.githubusercontent.com/adnnor/virtualhost-generator/master/vhgen.sh
$ chmod +x ./vhgen.sh
$ sudo mv vhgen.sh /usr/local/bin/vhgen
$ sudo vhgen
```
Sample output
```text

                                             #######################################
                                                 Welcome to VirtualHost Generator
                                             #######################################

Enter project name e.g. 'myproject': ad
Subdomain e.g. dev, staging: dev
TLD e.g. com, org: com
Set alias, leave blank for default dev.ad.com: 
Apache's DocumentRoot please, leave blank for /var/www: 
IP address for domain, leave blank for 127.0.0.1: 
Do you want to proceed? (y/n): y
Site dev.ad.com enabled
Done ...
DocumentRoot is /var/www/ad/dev/public_html
URL is dev.ad.com (Alias dev.ad.com)
Thank you :) ba bye!
```

> **DISCALIMER:** These instructions are made available for ease and not recommended for the production, owner will not be responsible of any damage or lose of data or whatsoever.
