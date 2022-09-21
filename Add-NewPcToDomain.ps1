<# This is where I'll learn to use the workflow function to continue scripts after a reboot.
Figure out the name you need before running this. It will rename the local pc to a new name, and then join that computer to the dsf domain
Date: June 30 2020        
#>

# Creates a new name based on your input
# First, specify the name of your workflow. You will call this upon reboot in powershell (as admin!)

workflow Rename-And-Reboot {
    
    param ([string]$Name)
    
    Read-Host -Prompt "Enter new computer name" -Outvariable computername

    Rename-Computer -NewName "$computername" -Confirm

    Restart-Computer -Wait
}


# After a reboot, the computer is joined to the domain

Read-Host -Prompt "Enter admin username" -Outvariable username | Out-Null

$cred = Get-Credential -credential "$username"

Add-Computer -domainName $domain -Credential $cred -PassThru -Verbose -Restart
