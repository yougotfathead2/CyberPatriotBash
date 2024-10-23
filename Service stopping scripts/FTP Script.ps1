# Define the service name
$serviceName = "FTPSvc"

# Check if the service exists
if (Get-Service -Name $serviceName -ErrorAction SilentlyContinue) {
    # Stop the FTP service if it is running
    if ((Get-Service -Name $serviceName).Status -eq 'Running') {
        Write-Host "Stopping the FTP service..."
        Stop-Service -Name $serviceName -Force
        Write-Host "FTP service stopped."
    } else {
        Write-Host "FTP service is not running."
    }

    # Disable the FTP service
    Write-Host "Disabling the FTP service..."
    Set-Service -Name $serviceName -StartupType Disabled
    Write-Host "FTP service has been disabled."
} else {
    Write-Host "FTP service not found."
}
