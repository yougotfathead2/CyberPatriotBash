function Check-LogDroppedPacketsSetting {
    $registryPath = "HKLM:\SOFTWARE\Policies\Microsoft\WindowsFirewall\DomainProfile\Logging"
    $logDroppedPacketsName = "LogDroppedPackets"

    # Check if the registry key exists
    if (Test-Path $registryPath) {
        $logDroppedPackets = Get-ItemProperty -Path $registryPath -Name $logDroppedPacketsName -ErrorAction SilentlyContinue

        if ($logDroppedPackets) {
            if ($logDroppedPackets.$logDroppedPacketsName -eq 1) {
                Write-Host "Logging of dropped packets is enabled."
            } else {
                Write-Host "Logging of dropped packets is not enabled. Applying the recommended setting..."
                Set-LogDroppedPacketsSetting
            }
        } else {
            Write-Host "LogDroppedPackets setting not found. Applying the recommended setting..."
            Set-LogDroppedPacketsSetting
        }
    } else {
        Write-Host "Registry path not found. Creating path and applying the recommended setting..."
        New-Item -Path $registryPath -Force
        Set-LogDroppedPacketsSetting
    }
}

function Set-LogDroppedPacketsSetting {
    $registryPath = "HKLM:\SOFTWARE\Policies\Microsoft\WindowsFirewall\DomainProfile\Logging"
    $logDroppedPacketsName = "LogDroppedPackets"
    $enableLogging = 1

    try {
        New-ItemProperty -Path $registryPath -Name $logDroppedPacketsName -PropertyType DWORD -Value $enableLogging -Force
        Write-Host "Logging of dropped packets has been enabled."
    } catch {
        Write-Host "An error occurred: $_"
    }
}

# Execute the function
Check-LogDroppedPacketsSetting
