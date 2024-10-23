function Check-InboundSetting {
    # Define the registry path for the Windows Firewall Domain Profile
    $regPath = "HKLM:\SOFTWARE\Policies\Microsoft\WindowsFirewall\DomainProfile"
    
    try {
        # Try to get the DefaultInboundAction value
        $inboundSetting = Get-ItemProperty -Path $regPath -Name DefaultInboundAction -ErrorAction Stop

        if ($inboundSetting.DefaultInboundAction -eq 1) {
            Write-Host "The inbound connections are blocked."
        } else {
            Write-Host "The inbound connections are not blocked. Applying the recommended setting..."
            Set-InboundSetting
        }
    } catch [System.Management.Automation.ItemNotFoundException] {
        Write-Host "The inbound connection setting was not found. Applying the recommended setting..."
        Set-InboundSetting
    } catch {
        Write-Host "An error occurred: $_"
    }
}

function Set-InboundSetting {
    # Define the registry path for the Windows Firewall Domain Profile
    $regPath = "HKLM:\SOFTWARE\Policies\Microsoft\WindowsFirewall\DomainProfile"
    
    try {
        # Set the DefaultInboundAction registry value to 1 (blocks inbound connections)
        Set-ItemProperty -Path $regPath -Name DefaultInboundAction -Value 1
        Write-Host "The inbound setting has been updated to the recommended value (block inbound connections)."
    } catch {
        Write-Host "An error occurred while updating the inbound setting: $_"
    }
}

# Run the check for the inbound firewall setting
Check-InboundSetting
