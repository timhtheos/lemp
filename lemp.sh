# Ubuntu 14.04 LTS x64

sudo apt-get update &&
  sudo apt-get upgrade -y &&
  sudo apt-get install vim git -y &&
  sudo apt-get install nginx -y &&
  sudo apt-get install mysql-server -y &&
  sudo mysql_install_db &&
  sudo mysql_secure_installation &&
  sudo apt-get install php5-fpm php5-mysql -y &&
  sudo sed -i -e 's/;cgi.fix_pathinfo=1/cgi.fix_pathinfo=0/g' /etc/php5/fpm/php.ini &&
  mkdir /var/www &&
  mkdir /var/www/default &&
  mkdir /var/www/default/html &&
  sudo sed -i -e 's/root \/usr\/share\/nginx\/html;/root \/var\/www\/default\/html;/g' /etc/nginx/sites-available/default &&
  sudo sed -i -e 's/index index.html index.htm;/index index.php index.html index.htm;/g' /etc/nginx/sites-available/default &&
  sudo sed -i -e 's/#error_page 404 \/404.html;/error_page 404 \/404.html;/g' /etc/nginx/sites-available/default &&
  sudo sed -i -e 's/#error_page 500 502 503 504 \/50x.html;/error_page 500 502 503 504 \/50x.html/g;' /etc/nginx/sites-available/default &&
  sudo sed -i -e '/#location = \/50x.html {/{n;N;d}' /etc/nginx/sites-available/default &&
  sudo sed -i -e '/#location = \/50x.html {/a \\\t\t root \/var\/www\/default\/html;/a \\\t }' /etc/nginx/sites-available/default &&
  sudo sed -i -e 's/#location = \/50x.html {/location = \/50x.html {/g' /etc/nginx/sites-available/default
