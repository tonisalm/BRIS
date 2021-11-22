#!/bin/bash

# *** Estas acciones se realizarían en el sistema del servidor web, pero en este caso es el mismo de la CA ***

# Importar el certificado de la CA al almacén de certificados
# NOTA: No es necesario hacer esto por encontrarse servidor web y CA en el mismo sistema
# sudo cp ~/ca.crt /usr/local/share/ca-certificates
# sudo update-ca-certificates

# Generar clave privada
# NOTA: No instalamos openssl porque ya se ha instalado con easy-rsa
# sudo apt update
# sudo apt -y install openssl
mkdir ~/prueba-csr
openssl genrsa -out ~/prueba-csr/iesjaumei.key

# Crear CSR
openssl req -new -passout pass:"anvorGesa#~01" -key ~/prueba-csr/iesjaumei.key -out ~/prueba-csr/iesjaumei.req -subj "/emailAddress=alurod302@ieselcaminas.org/C=ES/ST=Castellon/L=Castellon/O=IES\ Jaume\ I/OU=Dep-Informatica/CN=iesjaumei"

# Copiar la CSR al servidor de CA
# NOTA: Esto no es necesario por lo de siempre
# scp ~/prueba-csr/iesjaumei.req administrador@192.168.1.xx:

