# Script to enable Microsoft Defender Firewall for all profiles

# Enable Firewall for Domain Profile
$domainProfilePath = "HKLM:\SOFTWARE\Policies\Microsoft\WindowsFirewall\DomainProfile"
if (Test-Path $domainProfilePath) {
    Set-ItemProperty -Path $domainProfilePath -Name EnableFirewall -Value 1
    Write-Host "Domain profile firewall has been enabled."
} else {
    Write-Host "Domain profile path does not exist."
}

# Enable Firewall for Private Profile
$privateProfilePath = "HKLM:\SOFTWARE\Policies\Microsoft\WindowsFirewall\PrivateProfile"
if (Test-Path $privateProfilePath) {
    Set-ItemProperty -Path $privateProfilePath -Name EnableFirewall -Value 1
    Write-Host "Private profile firewall has been enabled."
} else {
    Write-Host "Private profile path does not exist."
}

# Enable Firewall for Public Profile
$publicProfilePath = "HKLM:\SOFTWARE\Policies\Microsoft\WindowsFirewall\PublicProfile"
if (Test-Path $publicProfilePath) {
    Set-ItemProperty -Path $publicProfilePath -Name EnableFirewall -Value 1
    Write-Host "Public profile firewall has been enabled."
} else {
    Write-Host "Public profile path does not exist."
}

# Check current firewall status
$firewallStatus = Get-NetFirewallProfile | Select-Object Name, Enabled
Write-Host "`nCurrent Firewall Status:"
$firewallStatus | Format-Table -AutoSize

# Optional: Enable the firewall using the built-in command (recommended for reliability)
Set-NetFirewallProfile -Profile Domain, Private, Public -Enabled True

Write-Host "`nMicrosoft Defender Firewall has been successfully enabled for all profiles."
