# Define a loop to ask for user details until the host decides to stop
do {
    # Ask for the username
    $username = Read-Host "Enter the name of the user (or type 'exit' to finish)"

    # Exit the loop if the user types "exit"
    if ($username -eq "exit") {
        break
    }

    # Check if the user already exists
    $existingUser = Get-LocalUser -Name $username -ErrorAction SilentlyContinue

    if ($existingUser) {
        # Check the user's current group membership
        $isAdmin = Get-LocalGroupMember -Group "Administrators" -Member $username -ErrorAction SilentlyContinue

        # Notify the current role of the user
        if ($isAdmin) {
            Write-Host "User '$username' already exists as an admin."
        }
        else {
            Write-Host "User '$username' already exists as a standard user."
        }

        # Ask if they want to change the user's role
        $changeRole = Read-Host "Would you like to change $username's role? (yes/no)"
        
        if ($changeRole -eq "yes") {
            # Ask for the new role
            $newRole = Read-Host "Should $username be changed to 'admin' or 'standard'?"

            # Check for valid input
            if ($newRole -ne "admin" -and $newRole -ne "standard") {
                Write-Host "Invalid role specified. Please enter either 'admin' or 'standard'."
                continue
            }

            # Update the user's group membership based on the new role
            if ($newRole -eq "admin") {
                # Remove from 'Users' group if necessary
                Remove-LocalGroupMember -Group "Users" -Member $username -ErrorAction SilentlyContinue
                # Add to 'Administrators' group
                Add-LocalGroupMember -Group "Administrators" -Member $username
                Write-Host "$username has been updated to an admin."
            }
            else {
                # Remove from 'Administrators' group if necessary
                Remove-LocalGroupMember -Group "Administrators" -Member $username -ErrorAction SilentlyContinue
                # Add to 'Users' group
                Add-LocalGroupMember -Group "Users" -Member $username
                Write-Host "$username has been updated to a standard user."
            }
        }
        else {
            Write-Host "Permissions for '$username' are unchanged."
        }
        
        continue
    }

    # Ask for the user role (admin or standard) if the user does not exist
    $role = Read-Host "Should this user be an 'admin' or 'standard'?"

    # Check for valid input
    if ($role -ne "admin" -and $role -ne "standard") {
        Write-Host "Invalid role specified. Please enter either 'admin' or 'standard'."
        continue
    }

    # Create the user account
    New-LocalUser -Name $username -NoPassword

    # Add the user to the appropriate group based on the role
    if ($role -eq "admin") {
        Add-LocalGroupMember -Group "Administrators" -Member $username
        Write-Host "$username has been created and added to the Administrators group."
    }
    else {
        Add-LocalGroupMember -Group "Users" -Member $username
        Write-Host "$username has been created as a standard user."
    }

} while ($true)

Write-Host "User creation process complete."
