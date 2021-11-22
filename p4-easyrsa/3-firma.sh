#!/bin/bash

# *** Estas acciones se realizan en el servidor donde está la CA ***

# Importar la CSR
# NOTA: Hay que estar en el directorio de easy-rsa, o no encuentra la PKI
cd ~/ca/easy-rsa
~/ca/easy-rsa/easyrsa import-req ~/prueba-csr/iesjaumei.req iesjaumei

# Firmar la CSR (en este comando hay que introducir información manual)
~/ca/easy-rsa/easyrsa sign-req server iesjaumei
# NOTA: Tras firmar habría que comprobar si se ha generado bien el certificado. Busca index.txt para ver su contenido

# Un poco de limpieza
cd ~
rm ~/prueba-csr/iesjaumei.req

# Mandar certificado al servidor web (en este caso no aplica por estar en el mismo sistema que la CA)
# scp ~/ca/easy-rsa/pki/issued/iesjaumei.crt toni@192.168.1.44:
# scp ~/ca/easy-rsa/pki/ca.crt toni@192.168.1.44:
