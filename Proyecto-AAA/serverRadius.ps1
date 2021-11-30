# 0. Previo a la instalación del servidor RADIUS, creamos usuario de pruebas y grupo

New-ADUser `
  -Name "vpntestuser" `
  -AccountPassword (ConvertTo-SecureString "test.VPN01" -AsPlainText -Force) `
  -Enabled $True

New-ADGroup `
  -Name "usuarios-vpn" `
  -GroupScope Global `
  -GroupCategory Security

Add-ADGroupMember `
  -Identity "usuarios-vpn" `
  -Members "vpntestuser"

# Hay que marcar "Controlar acceso a través de la directiva de red NPS" en las propiedades del usuario

# 1. Instalar el Rol Servicios de acceso y directivas de redes

Install-WindowsFeature -name NPAS -IncludeAllSubFeature -IncludeManagementTools

# 2. Configuracion del servidor RADIUS
# 2.1 Registrar el servidor NPS en Active Directory. 
#     De esta forma, el servidor tendra autoridad para leer las propiedades de las cuentas de usuario de Active Directory para autenticar a los usuarios. 
#     El servidor se agregará al grupo de dominio integrado Servidores RAS e IAS.
netsh ras add registeredserver


# 2.2 Añadir clientes radius
# https://docs.microsoft.com/en-us/powershell/module/nps/new-npsradiusclient?view=windowsserver2019-ps
# Este comando, configurara un cliente Radius,donde
# Name, sera el nombre que le daremos a la maquina que usaremos como cliente.
# Address sera la Ip de dicha maquina.
# VendorName sera el tipo de radius que usaremos.
# Sharesecret la contraseña para establecer la conexion.

New-NpsRadiusClient -Name "NAS-JAUMEI" -Address "192.168.1.63" -SharedSecret "cli.RAD~6259@sji" -VendorName "Radius Standard"

# Reiniciamos el servicio para que actualice las nueos clientes radius
Restart-Service IAS

# 2.3 Configurar NPS Policies
#     Las políticas de NPS permiten autenticar usuarios remotos y otorgarles permisos de acceso configurados en el rol de NPS.
#     1. Políticas de solitud de conexión
#     2. Políticas de red.
#     Se pueden crear en un servidor con GUI y exportarlas para luego importarlas en el Servidor Radius Core.     
#     Export-NpsConfiguration -Path c:\ps\backup_nps.xml
#     Import-NpsConfiguration -Path c:\ps\backup_nps.xml
nps.msc


