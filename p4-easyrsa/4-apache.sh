#!/bin/bash

# *** Estas acciones se realizarían desde el sistema del servidor web (en este caso el de la CA) ***

# Instalar apache
sudo apt -y install apache2

# Copiar claves privadas y públicas al almacén de certificados para usar con apache
sudo cp ~/prueba-csr/iesjaumei.key /etc/ssl/private/iesjaumei.key.pem
sudo cp ~/ca/easy-rsa/pki/issued/iesjaumei.crt /etc/ssl/certs/iesjaumei.cert.pem
sudo cp ~/ca/easy-rsa/pki/ca.crt /etc/ssl/certs/ca.cert.pem

# Configurar apache
sudo cp /etc/apache2/sites-available/default-ssl.conf /etc/apache2/sites-available/iesjaumei-ssl.conf
# Abrimos archivos de configuración para editar manualmente
sudo nano /etc/apache2/sites-available/iesjaumei-ssl.conf
# Añadir:
# ServerName iesjaumei.loc
# DocumentRoot /var/www/html/iesjaumei
# SSLCertificateFile      /etc/ssl/certs/iesjaumei.cert.pem
# SSLCertificateKeyFile /etc/ssl/private/iesjaumei.key.pem
# SSLCertificateChainFile /etc/ssl/certs/ca.cert.pem
# SSLVerifyClient require
# SSLVerifyDepth  10
sudo nano /etc/apache2/sites-available/000-default.conf
# Añadir (para redireccionar a https):
# ServerName iesjaumei.loc
# Redirect permanent / https://iesjaumei.loc

# Activamos el módulo ssl
sudo a2enmod ssl

# Crear la página web
sudo mkdir /var/www/html/iesjaumei
sudo cp /var/www/html/index.html /var/www/html/iesjaumei
# Modificamos permisos y nos añadimos al grupo www-data para poder modificar si es necesario
sudo chown -R www-data:www-data /var/www/html/iesjaumei
sudo addgroup administrador www-data

# Activar el sitio web
sudo a2ensite iesjaumei-ssl.conf
# Esto lo haríamos manualmente, para ver si todo está ok antes de reiniciar apache
# sudo apache2ctl configtest
sudo service apache2 restart

# Exportar certificado de la CA al cliente, para importarlo en el navegador y que confíe en el sitio web
scp ~/ca/easy-rsa/pki/ca.crt toni@192.168.1.44:

