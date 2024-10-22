function Check-OutboundFirewallSetting {
    # Check the current outbound setting for the Windows Firewall Domain Profile
    $regPath = "HKLM:\SOFTWARE\Policies\Microsoft\WindowsFirewall\DomainProfile"
    $outboundSetting = Get-ItemProperty -Path $regPath -Name DefaultOutboundAction -ErrorAction SilentlyContinue

    if ($outboundSetting.DefaultOutboundAction -eq 0) {
        Write-Host "Outbound connections are allowed."
    } else {
        Write-Host "Outbound connections are blocked. Updating the setting to allow..."
        Set-OutboundFirewallSetting
    }
}

function Set-OutboundFirewallSetting {
    # Update the outbound setting for the Windows Firewall Domain Profile to 'allow' (0)
    $regPath = "HKLM:\SOFTWARE\Policies\Microsoft\WindowsFirewall\DomainProfile"
    Set-ItemProperty -Path $regPath -Name DefaultOutboundAction -Value 0
    Write-Host "Outbound setting updated to allow connections."
}

# Run the check to ensure outbound connections are allowed
Check-OutboundFirewallSetting
