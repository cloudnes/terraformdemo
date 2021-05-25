Install-WindowsFeature -Name Web-Server -IncludeAllSubFeature -IncludeManagementTools
New-WebBinding -Name "Default Web Site" -Protocol https -Port 443
$cert= Get-ChildItem cert:\localmachine\My | Where-Object -FilterScript {$_.friendlyname -ne 'WMSVC-SHA2' -and  $_.friendlyname -ne 'TenantEncryptionCert' }
(Get-WebBinding -Name "Default Web Site" -Port 443 -Protocol "https").AddSslCertificate($cert.Thumbprint, "My")