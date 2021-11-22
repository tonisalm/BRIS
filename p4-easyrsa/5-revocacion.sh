#!/bin/bash

# *** Estas acciones se realizarían desde el sistema de la CA ***

# Revocar el certificado y generar la CRL (hay que estar en easy-rsa para que encuentre la PKI)
cd ~/ca/easy-rsa
./easyrsa revoke iesjaumei
./easyrsa gen-crl

# Esto sería para comprobar que realmente está revocado
# openssl crl -in pki/crl.pem -noout -text

# Copiar la crl al sistema del servidor web (en este caso está donde la CA, así que no lo hacemos)
# scp ~/ca/easy-rsa/pki/crl.pem usuario@ip_serv_web:

# *** Estas acciones se realizarían desde el sistema del servidor web ***

# Copiar la CRL a donde sea que vayan las crl (creo esa carpeta mismo)
sudo mkdir /etc/ssl/crl
sudo cp ~/ca/easy-rsa/pki/crl.pem /etc/ssl/crl

# Configurar apache para que utilice la crl
sudo nano /etc/apache2/sites-available/iesjaumei-ssl.conf
# Habría que añadir:
# SSLCARevocationCheck chain
# SSLCARevocationFile "/etc/ssl/crl/crl.pem"
# Más info: buscar "SSLCARevocation" en https://httpd.apache.org/docs/2.4/mod/mod_ssl.html

# Reiniciar apache
sudo service apache2 restart
