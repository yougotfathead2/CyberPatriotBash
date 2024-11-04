# Define the service name for World Wide Web Publishing Service
$serviceName = "W3SVC"

# Check if the service is installed
$service = Get-Service -Name $serviceName -ErrorAction SilentlyContinue

if ($service) {
    # Stop the service if it is running
    if ($service.Status -eq "Running") {
        Write-Host "Stopping the World Wide Web Publishing Service..."
        Stop-Service -Name $serviceName -Force
        Write-Host "Service stopped."
    }
    else {
        Write-Host "The World Wide Web Publishing Service is already stopped."
    }

    # Disable the service to prevent it from starting automatically
    Write-Host "Disabling the World Wide Web Publishing Service..."
    Set-Service -Name $serviceName -StartupType Disabled
    Write-Host "Service has been disabled."
}
else {
    Write-Host "The World Wide Web Publishing Service is not installed on this machine."
}

Write-Host "Script execution complete."
