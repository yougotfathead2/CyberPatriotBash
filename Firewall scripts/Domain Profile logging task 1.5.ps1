function Check-LogFilePathSetting {
    # Define the registry path for the Windows Firewall Domain Profile logging
    $regPath = "HKLM:\SOFTWARE\Policies\Microsoft\WindowsFirewall\DomainProfile\Logging"
    $recommendedLogPath = "%SystemRoot%\System32\logfiles\firewall\domainfw.log"

    try {
        # Query the LogFilePath setting from the registry
        $logFilePathSetting = Get-ItemProperty -Path $regPath -Name LogFilePath -ErrorAction Stop

        if ($logFilePathSetting.LogFilePath -eq $recommendedLogPath) {
            Write-Host "The log file path is set to the recommended value."
        } else {
            Write-Host "The log file path is not set to the recommended value. Applying the recommended setting..."
            Set-LogFilePathSetting
        }
    } catch [System.Management.Automation.ItemNotFoundException] {
        Write-Host "The log file path setting was not found. Applying the recommended setting..."
        Set-LogFilePathSetting
    } catch {
        Write-Host "An error occurred: $_"
    }
}

function Set-LogFilePathSetting {
    # Define the registry path and recommended log file path
    $regPath = "HKLM:\SOFTWARE\Policies\Microsoft\WindowsFirewall\DomainProfile\Logging"
    $recommendedLogPath = "%SystemRoot%\System32\logfiles\firewall\domainfw.log"

    try {
        # Set the LogFilePath registry value to the recommended path
        Set-ItemProperty -Path $regPath -Name LogFilePath -Value $recommendedLogPath -Type ExpandString
        Write-Host "The log file path has been updated to the recommended value."
    } catch {
        Write-Host "An error occurred while updating the log file path setting: $_"
    }
}

# Run the check for the log file path setting
Check-LogFilePathSetting
