#!/usr/bin/env bash
<<<<<<< HEAD
# Setting up web server for deployment.

apt-get update
apt-get install -y nginx

mkdir -p /data/web_static/releases/test/
mkdir -p /data/web_static/shared/
echo "Holberton School" > /data/web_static/releases/test/index.html
ln -sf /data/web_static/releases/test/ /data/web_static/current

chown -R ubuntu /data/
chgrp -R ubuntu /data/

printf %s "server {
    listen 80 default_server;
    listen [::]:80 default_server;
    add_header X-Served-By $hostname;
    root   /var/www/html;
    index  index.html index.htm;
    location /hbnb_static {
        alias /data/web_static/current;
        index index.html index.htm;
    }
    location /redirect_me {
        return 301 https://www.youtube.com/watch?v=QH2-TGUlwu4;
    }
    error_page 404 /404.html;
    location /404 {
      root /var/www/html;
      internal;
    }
}" > /etc/nginx/sites-available/default

=======
# Sets up the web servers for the deployment of web_static.

# Install Nginx if not already installed
apt update -y >/dev/null 2>&1
apt install nginx -y >/dev/null 2>&1

# Create required directories if they don't exist
mkdir -p /data/web_static/
mkdir -p /data/web_static/releases/
mkdir -p /data/web_static/shared/
mkdir -p /data/web_static/releases/test/

# Create fake index.html file
echo -e "<html>\n\t<head>\n\t</head>\n\t<body>\n\t\tHolberton School\n\t</body>\n</html>" >/data/web_static/releases/test/index.html

# Create the symbolic link
ln -sf /data/web_static/releases/test /data/web_static/current

# Change ownership of files and folders inside of /data folder
chown -hR ubuntu:ubuntu /data

# Add alias to serve the content of /data/web_static/current to hbnb_static
sed -i '51i\\tlocation /hbnb_static/ {\n\t\talias /data/web_static/current/;\n\t}\n' /etc/nginx/sites-available/default

# Restart the nginx service
>>>>>>> 65edb161fde4681e45545a2fdd50ba5f5ae48df6
service nginx restart
