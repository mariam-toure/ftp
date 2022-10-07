#!/bin/zsh
sudo apt install proftpd
sudo cp proftpd.conf.backup /etc/proftp/proftpd.conf
sudo service restart proftpd 


