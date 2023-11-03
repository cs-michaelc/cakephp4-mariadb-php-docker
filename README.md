# CakePHP 4.5 | PHP 8.2 | Apache/2.4.57 (Debian) | MariaDB 11.1.2

## Prerequisites
- Docker installed on your local machine
- Composer installed globally or locally
- Freshly installed Cakephp 4.5 Using Composer

# Install Composer
```bash
php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
php -r "if (hash_file('sha384', 'composer-setup.php') === 'e21205b207c3ff031906575712edab6f13eb0b361f2085f1f1237b7126d785e826a450292b6cfd1d64d92e6563bbde02') { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;"
php composer-setup.php
php -r "unlink('composer-setup.php');"
```

Initiate and run your local copy of Cakephp4
```bash
composer create-project --prefer-dist cakephp/app:~4.0 myapp
```

## Introduction

This project is a CakePHP 4.5 application running on PHP 8.2, Apache/2.4.57, and MariaDB 11.1.2. This README will guide you through the installation process.

## Installation
While inside your fresh Cakephp4

1. **Clone the Repository:**

   ```bash
   https://github.com/cs-michaelc/cakephp4-mariadb-php-docker
   ```

2. **Modify MariaDB Configuration:**

Open the docker-compose.yml file and locate the db service. Modify the MYSQL_ROOT_PASSWORD and MYSQL_DATABASE values to your preferred values. 

For example:

```bash
	environment:
	  	MYSQL_ROOT_PASSWORD: mysecretpassword
	  	MYSQL_DATABASE: myapp
 ```

3. **Change the base Setting in config/app.php:**

Open the config/app.php file in your CakePHP application. Update the 'base' value from / to false:

```bash
'App' => [
    'namespace' => 'App',
    'encoding' => env('APP_ENCODING', 'UTF-8'),
    'defaultLocale' => env('APP_DEFAULT_LOCALE', 'en_US'),
    'defaultTimezone' => env('APP_DEFAULT_TIMEZONE', 'UTC'),
    'base' => false,
],
```

4. **Change the Datasource host in config/app_local.php:**

Open the config/app.php file in your CakePHP application. Update the 'host' value from localhost to myapp_db_1:

Note: myapp_db_1 is the name of the mariadb container once you build the dockerfile and docker-compose file.

```bash
    'Datasources' => [
        'default' => [
            'host' => 'myapp_db_1',
```

5. **Build and Start Docker Containers:**

Run the following commands to build and start the Docker containers:
```bash
docker-compose build
docker-compose up -d
```

6. **Access the Application:**

Open your web browser and access the application at http://localhost.


Run dockers ps -a to check if the containers are running
docker ps -a

## Access Container 
You may need to access the container for various tasks. Here's how to do it:

1. To go inside the webapp container, run the following command:
```bash
docker exec -it myapp_web_1 bash
```
Once inside the container, you can run commands specific to the web application.

To install additional packages, for example run the following commands inside the container:

```bash
composer require "cakephp/authentication:^2.4"
composer require "cakephp/authorization:^2.0"
```

2. To set up your database or perform database-related tasks, access the MariaDB container:
```bash
docker exec -it myapp_db_1 bash
```

Log in to the MariaDB server by running:
```bash
mysql -u root -p
```

* Note that changes made to your codebase will be automatically synced with the Docker container instance.