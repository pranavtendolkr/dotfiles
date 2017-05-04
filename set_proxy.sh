#!/bin/bash

if [ $(id -u) -ne 0 ]; then
echo "This script must be run as root";
exit 1;
fi

if [ $# -eq 4 ]; then

gsettings set org.gnome.system.proxy mode 'manual' ;
gsettings set org.gnome.system.proxy.http host '$1';
gsettings set org.gnome.system.proxy.http port $2;
gsettings set org.gnome.system.proxy.http authentication-user '$3';
gsettings set org.gnome.system.proxy.http authentication-password '$4';


grep PATH /etc/environment > lol.t;
printf \
"http_proxy=http://$3:$4@$1:$2/\n\
 https_proxy=http://$3:$4@$1:$2/\n\
 ftp_proxy=http://$3:$4@$1:$2/\n\
 no_proxy=\"localhost,127.0.0.1,localaddress,.localdomain.com\"\n\
 HTTP_PROXY=http://$3:$4@$1:$2/\n\
 HTTPS_PROXY=http://$3:$4@$1:$2/\n\
 FTP_PROXY=http://$3:$4@$1:$2/\n\
 NO_PROXY=\"localhost,127.0.0.1,localaddress,.localdomain.com\"\n" >> lol.t;

 cat lol.t > /etc/environment;
 
 source /etc/environment

 printf \
 "Acquire::http::proxy \"http://$3:$4@$1:$2/\";\n\
  Acquire::ftp::proxy \"ftp://$3:$4@$1:$2/\";\n\
  Acquire::https::proxy \"https://$3:$4@$1:$2/\";\n" > /etc/apt/apt.conf.d/95proxies;

 rm -rf lol.t

 git config --global http.proxy http://$3:$4@$1:$2

else

 printf "Usage $0 <proxy_ip> <proxy_port> <username> <password>\n";

fi

