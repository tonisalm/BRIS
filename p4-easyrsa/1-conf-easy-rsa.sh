#!/bin/bash

# *** Estas acciones se realizan en el sistema donde se va a montar la CA ***

# Instalación de paquetes requeridos
sudo apt update
sudo apt -y install openvpn easy-rsa

# Creación estructura PKI
mkdir ~/ca
mkdir ~/ca/easy-rsa
ln -s /usr/share/easy-rsa/* ~/ca/easy-rsa/
chmod -R 700 ~/ca
~/ca/easy-rsa/easyrsa init-pki

# Creación de la CA
echo set_var EASYRSA_REQ_COUNTRY "ES" > ~/ca/easy-rsa/vars
echo set_var EASYRSA_REQ_PROVINCE "Castellon" >> ~/ca/easy-rsa/vars
echo set_var EASYRSA_REQ_CITY "Castellon" >> ~/ca/easy-rsa/vars
echo set_var EASYRSA_REQ_ORG "IESJaumeI" >> ~/ca/easy-rsa/vars
echo set_var EASYRSA_REQ_EMAIL "alurod302@ieselcaminas.org" >> ~/ca/easy-rsa/vars
echo set_var EASYRSA_REQ_OU "Dep-Informatica" >> ~/ca/easy-rsa/vars
echo set_var EASYRSA_ALGO "ec" >> ~/ca/easy-rsa/vars
echo set_var EASYRSA_DIGEST "sha512" >> ~/ca/easy-rsa/vars
~/ca/easy-rsa/easyrsa build-ca

# Exportación del certificado de la CA al servidor web, para crear la CSR
# NOTA: En este caso no lo hacemos porque el servidor web va a montarse en el mismo sistema de la CA
# scp ~/ca/easy-rsa/pki/ca.crt toni@192.168.1.44:
