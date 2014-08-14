# Init script for MVMEM

echo "Commencing MVMEM Setup"

# Make a database, if we don't already have one
echo "Creating database (if it's not already there)"
mysql -u root --password=root -e "CREATE DATABASE IF NOT EXISTS mvmem"
mysql -u root --password=root -e "GRANT ALL PRIVILEGES ON mvmem.* TO wp@localhost IDENTIFIED BY 'wp';"

# Download WordPress
if [ ! -d htdocs ]
then
	echo "Installing WordPress using WP CLI"
	mkdir htdocs
	cd htdocs
	wp core download 
	wp core config --dbname="mvmem" --dbuser=wp --dbpass=wp --dbhost="localhost"
	wp core install --url=mvmem.dev --title="MVMEM Local" --admin_user=admin --admin_password=password --admin_email=matt@antym.com
	cd ..
fi

# The Vagrant site setup script will restart Nginx for us

echo "MVMEM Local site now installed";
