# Configuración de un cliente RADIUS

# Instalar el ROl 'Enrutamiento y acceso remoto'
Install-WindowsFeature DirectAccess-VPN -IncludeManagementTools

# Comprobar el cumplimiento de prerrequisitos
Install-RemoteAccess -PreRequisite

# Instalar VPN
Install-RemoteAccess `
  -VpnType VPN `
  -RadiusServer 192.168.1.62 `
  -SharedSecret "cli.RAD~6259@sji" `
  -IPAddressRange 192.168.1.100, 192.168.1.130

# Establecer el servidor RADIUS para autenticación de cuentas
Set-RemoteAccessAccounting `
  -EnableAccountingType ExternalRadius `
  -RadiusServer 192.168.1.62 `
  -SharedSecret "cli.RAD~6259@sji"

# Definir la seguridad de VPN
Set-VpnAuthProtocol -UserAuthProtocolAccepted MsChapv2

# Reiniciar el servicio para aplicar la configuración
Restart-Service RemoteAccess