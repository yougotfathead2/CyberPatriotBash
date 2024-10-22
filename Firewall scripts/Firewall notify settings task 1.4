function Check-NotificationSetting {
    # Define the registry path for the Windows Firewall Domain Profile
    $regPath = "HKLM:\SOFTWARE\Policies\Microsoft\WindowsFirewall\DomainProfile"

    try {
        # Query the DisableNotifications setting from the registry
        $notificationSetting = Get-ItemProperty -Path $regPath -Name DisableNotifications -ErrorAction Stop

        if ($notificationSetting.DisableNotifications -eq 0) {
            Write-Host "Notifications are enabled."
        } else {
            Write-Host "Notifications are disabled. Applying the recommended setting..."
            Set-NotificationSetting
        }
    } catch [System.Management.Automation.ItemNotFoundException] {
        Write-Host "The notification setting was not found. Applying the recommended setting..."
        Set-NotificationSetting
    } catch {
        Write-Host "An error occurred: $_"
    }
}

function Set-NotificationSetting {
    # Define the registry path for the Windows Firewall Domain Profile
    $regPath = "HKLM:\SOFTWARE\Policies\Microsoft\WindowsFirewall\DomainProfile"

    try {
        # Set the DisableNotifications value to 0 (enables notifications)
        Set-ItemProperty -Path $regPath -Name DisableNotifications -Value 0
        Write-Host "The notification setting has been updated to enable notifications."
    } catch {
        Write-Host "An error occurred while updating the notification setting: $_"
    }
}

# Run the check for the notification setting
Check-NotificationSetting
