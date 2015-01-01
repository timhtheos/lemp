# Ubuntu 14.04 LTS x64

# Run updates;
sudo apt-get update &&
  sudo apt-get upgrade -y &&

  # Install/configure git;
  sudo apt-get install git -y &&
  sudo git config --global user.email "none@none.none" &&
  sudo git config --global user.name "None" &&

  # Install Nginx and MySQL server;
  # @todo: Install nginx with specific version 1.4.6
  sudo apt-get install nginx -y &&
  sudo apt-get install mysql-server -y &&

  # Secure mysql server;
  sudo mysql_install_db &&
  sudo mysql_secure_installation &&

  # Install PHP;
  sudo apt-get install php5-fpm php5-mysql -y &&

  # Configure PHP;
  sudo sed -i -e 's/;cgi.fix_pathinfo=1/cgi.fix_pathinfo=0/g' /etc/php5/fpm/php.ini &&

  # Create directories for default server path;
  mkdir /var/www &&
  mkdir /var/www/default &&
  mkdir /var/www/default/html &&

  # Versionize the Server Blocks (equivalent to Apache2's Virtual Host);
  sudo git init /etc/nginx/sites-available/ &&
  cd /etc/nginx/sites-available/ &&
  sudo git add . &&
  sudo git commit -m "Original state;" &&
  cd ~ &&

  # Configure default Server Block;
  sudo sed -i -e 's/root \/usr\/share\/nginx\/html;/root \/var\/www\/default\/html;/g' /etc/nginx/sites-available/default &&
  sudo sed -i -e 's/index index.html index.htm;/index index.php index.html index.htm;/g' /etc/nginx/sites-available/default &&
  sudo sed -i -e 's/#error_page 404 \/404.html;/error_page 404 \/404.html;/g' /etc/nginx/sites-available/default &&
  sudo sed -i -e 's/#error_page 500 502 503 504 \/50x.html;/error_page 500 502 503 504 \/50x.html/g;' /etc/nginx/sites-available/default &&
  sudo sed -i -e '/#location = \/50x.html {/{n;N;d}' /etc/nginx/sites-available/default &&
  sudo sed -i -e '/#location = \/50x.html {/a \\t}' /etc/nginx/sites-available/default &&
  sudo sed -i -e '/#location = \/50x.html {/a \\t\troot \/var\/www\/default\/html;' /etc/nginx/sites-available/default &&
  sudo sed -i -e 's/#location = \/50x.html {/location = \/50x.html {/g' /etc/nginx/sites-available/default &&
  sudo sed -i -e 's/#location ~ \\.php$ {/location ~ \\.php$ {/g' /etc/nginx/sites-available/default &&
  sudo sed -i -e 's/#\tfastcgi_split_path_info/\tfastcgi_split_path_info/g' /etc/nginx/sites-available/default &&
  sudo sed -i -e 's/#\tfastcgi_pass unix/\tfastcgi_pass unix/g' /etc/nginx/sites-available/default &&
  sudo sed -i -e 's/#\tfastcgi_index/\tfastcgi_index/g' /etc/nginx/sites-available/default &&
  sudo sed -i -e 's/#\tinclude fastcgi_params/\tinclude fastcgi_params/g' /etc/nginx/sites-available/default &&
  sudo sed -i -e '/fastcgi_params;/{n;d}' /etc/nginx/sites-available/default &&
  sudo sed -i -e '/fastcgi_params;/a \\t}' /etc/nginx/sites-available/default &&

  # Restart Nginx;
  sudo service nginx restart
