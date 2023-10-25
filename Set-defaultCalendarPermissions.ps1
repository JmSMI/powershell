# Start transcript
Start-Transcript -Path "C:\temp\logs\calendarPermissions.log"

# Permissions
$Permission = "LimitedDetails"

# Get all user mailboxes
$Users = Get-Mailbox -ResultSize Unlimited -RecipientTypeDetails UserMailbox

# Users exception
# Create a file called exclusions.txt in script directory. Add one userPrincipalName per line
if(-not(Test-Path .\exclufsions.txt)) {
    $checking = $true
    while($checking) {
        $input = Read-Host "Missing exclusions file. Proceed? y/n"
        if ($input -eq "n") {exit 0}
        if ($input -eq "y") {$checking = $false}
    }
}
else {
    $Exception = Get-Content .\exclusions.txt
}

# Loop through each user
foreach ($User in $Users) {

    # Leave permissions if user is exception
    if ($Exception -Contains ($User.UserPrincipalName)) {
        Write-Host "$User is an exception" -ForegroundColor Red
    }
    else {
        $Cal = "$($User.UserPrincipalName):\calendar"
        $CurrentMailFolderPermission = Get-MailboxFolderPermission -Identity $Cal -User Default
        
        # Set calendar permission / Remove -WhatIf parameter after testing
        Set-MailboxFolderPermission -Identity $Cal -User Default -AccessRights $Permission -WarningAction:SilentlyContinue
        
        # Write output
        if ($CurrentMailFolderPermission.AccessRights -eq "$Permission") {
            Write-Host $User.DisplayName already has the permission $CurrentMailFolderPermission.AccessRights -ForegroundColor Yellow
        }
        else {
            Write-Host $User.DisplayName added permissions $Permission -ForegroundColor Green
        }
    }
}

Stop-Transcript