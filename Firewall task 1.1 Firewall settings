function Check-FirewallSetting {
    # Define the registry path for the Windows Firewall Domain Profile
    $regPath = "HKLM:\SOFTWARE\Policies\Microsoft\WindowsFirewall\DomainProfile"
    
    try {
        # Try to get the EnableFirewall value
        $firewallSetting = Get-ItemProperty -Path $regPath -Name EnableFirewall -ErrorAction Stop

        if ($firewallSetting.EnableFirewall -eq 1) {
            Write-Host "The firewall is enabled."
        } else {
            Write-Host "The firewall is disabled. Applying the recommended setting..."
            Set-FirewallSetting
        }
    } catch [System.Management.Automation.ItemNotFoundException] {
        Write-Host "The firewall setting was not found. Applying the recommended setting..."
        Set-FirewallSetting
    } catch {
        Write-Host "An error occurred: $_"
    }
}

function Set-FirewallSetting {
    # Define the registry path for the Windows Firewall Domain Profile
    $regPath = "HKLM:\SOFTWARE\Policies\Microsoft\WindowsFirewall\DomainProfile"
    
    try {
        # Set the EnableFirewall registry value to 1 (enabled)
        Set-ItemProperty -Path $regPath -Name EnableFirewall -Value 1
        Write-Host "The firewall setting has been updated to the recommended value."
    } catch {
        Write-Host "An error occurred while updating the firewall setting: $_"
    }
}

# Run the check for the firewall setting
Check-FirewallSetting
