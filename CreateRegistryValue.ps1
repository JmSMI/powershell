<#
.SYNOPSIS
This PowerShell script creates a new dword value within an existing registry key and
logs the action to a transcript log file.

.DESCRIPTION
Author: James Moffat
Date: October 19, 2023

This script allows you to create a new dword value within an existing registry key. 
It also logs the actions to a transcript log file located in C:\temp\logs. 
The script checks if the destination key exists, creates it if necessary, and then creates the new value.

To use this script, modify the values for $keyPath, $valueName, and $valueData according 
to your requirements. Ensure that you have the necessary permissions to modify the registry and
write to the log file.

.PARAMETER None
No parameters are required. Customize the values within the script to suit your needs.

.EXAMPLE
.\CreateRegistryValue.ps1

This command executes the script with default values. 
Make sure to modify the script with your specific registry key and value information.

#>

# Function to create a new string value within an existing registry key
function Create-RegistryValue {
    # Set the path to the registry key where you want to create the new value
    $keyPath = "HKLM:\Software\Policies\Microsoft\OneDrive"

    # Specify the name and data for the new string value
    $valueName = "EnableSyncAdminReports"

    # Set the path for the transcript log file
    $logPath = "C:\temp\logs\EnableOneDriveSyncReports.txt"

    # Start a transcript log
    Start-Transcript -Path $logPath -Append

    # Create the new string value in the registry key
    $valueExists = Get-ItemProperty -Path $keyPath -Name $valueName

    Write-Host "`nKey path: $keypath\$valuename"

    if ($valueExists -ne $null) {
        Remove-ItemProperty -Path $keyPath -Name $valueName

        New-ItemProperty -Path $keyPath -Name $valueName -Value 1 -PropertyType DWord
    } else {
        New-ItemProperty -Path $keyPath -Name $valueName -Value 1 -PropertyType DWord
        }

    # Stop the transcript log
    Stop-Transcript
}

# Call the function to create the registry value and log the action
Create-RegistryValue
