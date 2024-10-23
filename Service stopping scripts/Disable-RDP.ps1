# Disable Remote Desktop Protocol (RDP) service

# Function to check if the user has administrator rights
function Check-Admin {
    $adminCheck = [Security.Principal.WindowsPrincipal]([Security.Principal.WindowsIdentity]::GetCurrent())
    $isAdmin = $adminCheck.IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)
    
    if (-not $isAdmin) {
        Write-Host "You must run this script as an administrator." -ForegroundColor Red
        exit
    }
}

# Run the function to check for administrator rights
Check-Admin

# Define the RDP service name
$serviceName = "TermService"

# Stop the service if it is running
$service = Get-Service -Name $serviceName -ErrorAction SilentlyContinue
if ($service.Status -eq 'Running') {
    Write-Host "Stopping the RDP service..." -ForegroundColor Yellow
    Stop-Service -Name $serviceName -Force
    Write-Host "RDP service stopped." -ForegroundColor Green
} else {
    Write-Host "RDP service is not running." -ForegroundColor Cyan
}

# Disable the service
Set-Service -Name $serviceName -StartupType Disabled
Write-Host "RDP service has been disabled." -ForegroundColor Green

# Disable RDP from the system settings (Registry Key)
Write-Host "Disabling RDP in the system settings..." -ForegroundColor Yellow
Set-ItemProperty -Path 'HKLM:\SYSTEM\CurrentControlSet\Control\Terminal Server' -Name 'fDenyTSConnections' -Value 1
Write-Host "RDP access has been disabled via system settings." -ForegroundColor Green

Write-Host "RDP service has been successfully disabled." -ForegroundColor Green
