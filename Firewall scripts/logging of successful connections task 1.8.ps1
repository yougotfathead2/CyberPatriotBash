function Check-LogSuccessfulConnectionsSetting {
    $registryPath = "HKLM:\SOFTWARE\Policies\Microsoft\WindowsFirewall\DomainProfile\Logging"
    $logSuccessfulConnectionsName = "LogSuccessfulConnections"

    # Check if the registry key exists
    if (Test-Path $registryPath) {
        $logSuccessfulConnections = Get-ItemProperty -Path $registryPath -Name $logSuccessfulConnectionsName -ErrorAction SilentlyContinue

        if ($null -ne $logSuccessfulConnections) {
            if ($logSuccessfulConnections.$logSuccessfulConnectionsName -eq 1) {
                Write-Host "Logging of successful connections is enabled."
            } else {
                Write-Host "Logging of successful connections is not enabled. Applying the recommended setting..."
                Set-LogSuccessfulConnectionsSetting
            }
        } else {
            Write-Host "LogSuccessfulConnections setting not found. Applying the recommended setting..."
            Set-LogSuccessfulConnectionsSetting
        }
    } else {
        Write-Host "Registry path not found. Creating path and applying the recommended setting..."
        New-Item -Path $registryPath -Force
        Set-LogSuccessfulConnectionsSetting
    }
}

function Set-LogSuccessfulConnectionsSetting {
    $registryPath = "HKLM:\SOFTWARE\Policies\Microsoft\WindowsFirewall\DomainProfile\Logging"
    $logSuccessfulConnectionsName = "LogSuccessfulConnections"
    $enableLogging = 1

    try {
        New-ItemProperty -Path $registryPath -Name $logSuccessfulConnectionsName -PropertyType DWORD -Value $enableLogging -Force
        Write-Host "Logging of successful connections has been enabled."
    } catch {
        Write-Host "An error occurred: $($_.Exception.Message)"
    }
}

# Execute the function
Check-LogSuccessfulConnectionsSetting
