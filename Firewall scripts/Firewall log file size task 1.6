function Check-LogFileSizeSetting {
    $registryPath = "HKLM:\SOFTWARE\Policies\Microsoft\WindowsFirewall\DomainProfile\Logging"
    $logFileSizeName = "LogFileSize"

    # Check if the registry key exists
    if (Test-Path $registryPath) {
        $logFileSize = Get-ItemProperty -Path $registryPath -Name $logFileSizeName -ErrorAction SilentlyContinue

        if ($logFileSize) {
            if ($logFileSize.$logFileSizeName -ge 16384) {
                Write-Host "The log file size is set to the recommended value or greater."
            } else {
                Write-Host "The log file size is not set to the recommended value. Applying the recommended setting..."
                Set-LogFileSizeSetting
            }
        } else {
            Write-Host "LogFileSize setting not found. Applying the recommended setting..."
            Set-LogFileSizeSetting
        }
    } else {
        Write-Host "Registry path not found. Creating path and applying the recommended setting..."
        New-Item -Path $registryPath -Force
        Set-LogFileSizeSetting
    }
}

function Set-LogFileSizeSetting {
    $registryPath = "HKLM:\SOFTWARE\Policies\Microsoft\WindowsFirewall\DomainProfile\Logging"
    $logFileSizeName = "LogFileSize"
    $recommendedSize = 16384

    try {
        New-ItemProperty -Path $registryPath -Name $logFileSizeName -PropertyType DWORD -Value $recommendedSize -Force
        Write-Host "The log file size has been updated to the recommended value."
    } catch {
        Write-Host "An error occurred: $_"
    }
}

# Execute the function
Check-LogFileSizeSetting
