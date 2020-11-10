# create folder
mkdir -p /zbx-server/mysql/data

# MYSQL
docker container run -d -p 3306:3306 -v /zbx-server/mysql/data:/var/lib/mysql -e MYSQL_HOST=192.168.222.50 -e MYSQL_USER=zabbix -e MYSQL_ROOT_PASSWORD=zabbix -e MYSQL_DATABASE=zabbix -e MYSQL_PASSWORD=zabbix --name mysql-zbx mysql:5.7

# ZABBIX SERVER
docker container run -d -p 10051:10051 -e MYSQL_ROOT_PASSWORD=zabbix -e DB_SERVER_HOST=zabbix -e DB_SERVER_HOST=192.168.222.50 -e DB_SERVER_PORT=3306 -e MYSQL_USER=zabbix -e MYSQL_PASSWORD=zabbix -e MYSQL_DATABASE=zabbix --name zbx-server zabbix/zabbix-server-mysql:centos-5.2-latest


#ZABBIX WEB
docker container run -d -p 80:8080 -p 443:8443 -e DB_SERVER_HOST=192.168.222.50 -e DB_SERVER_PORT=3306 -e MYSQL_USER=zabbix -e MYSQL_PASSWORD=zabbix -e MYSQL_DATABASE=zabbix -e ZBX_SERVER_HOST=192.168.222.50 -e PHP_TZ=Europe/London --name zbx-web zabbix/zabbix-web-apache-mysql:centos-5.2-latest


