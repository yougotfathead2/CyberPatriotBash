# Ask the host for the list of users to add to the group
Write-Host "Enter the usernames you want to add to the group, separated by commas."
$usernamesInput = Read-Host "Usernames"

# Split the input string by commas and trim any extra whitespace
$usernames = $usernamesInput -split ',' | ForEach-Object { $_.Trim() }

# Ask the host for a name for the new group
$groupName = Read-Host "Enter a name for the new group"

# Check if the group already exists
$existingGroup = Get-LocalGroup -Name $groupName -ErrorAction SilentlyContinue

if ($existingGroup) {
    Write-Host "The group '$groupName' already exists. Updating its members based on the list provided."
} else {
    # Create the new group
    New-LocalGroup -Name $groupName
    Write-Host "Group '$groupName' has been created."
}

# Get current members of the group
$currentMembers = (Get-LocalGroupMember -Group $groupName | Where-Object { $_.objectClass -eq 'User' }).Name

# Add users in the list provided by the host
foreach ($username in $usernames) {
    # Check if the user exists
    $userExists = Get-LocalUser -Name $username -ErrorAction SilentlyContinue

    if ($userExists) {
        # Add the user to the group if they are not already a member
        if ($currentMembers -notcontains $username) {
            Add-LocalGroupMember -Group $groupName -Member $username
            Write-Host "User '$username' has been added to the group '$groupName'."
        } else {
            Write-Host "User '$username' is already in the group '$groupName'."
        }
    } else {
        Write-Host "User '$username' does not exist and could not be added to the group."
    }
}

# Remove users from the group who are not in the initial list
foreach ($member in $currentMembers) {
    if ($usernames -notcontains $member) {
        Remove-LocalGroupMember -Group $groupName -Member $member
        Write-Host "User '$member' has been removed from the group '$groupName' as they were not in the initial list."
    }
}

Write-Host "Group '$groupName' has been updated with the specified members."
