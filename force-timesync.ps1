<#
.SYNOPSIS
This PowerShell script forces a time resynchronization with an NTP server, helping to address issues related to daylight saving time changes.

.DESCRIPTION
This script can be used to ensure that Windows synchronizes its time accurately, especially when daylight saving time changes occur. 
It performs the following tasks:
1. Starts a transcript to log the script's output.
2. Attempts to force a time resynchronization with the NTP server.
3. Logs any errors that occur during the process.
4. Sets an exit code to indicate the success or failure of the synchronization.
5. Stops the transcript, finishing the log.

.NOTES
File Name      : Force-TimeSync.ps1
Author         : James Moffat
Version        : 1.0

.EXAMPLE
.\Force-TimeSync.ps1
This command runs the script to force a time resynchronization and logs the output to C:\temp\logs\dst.txt.

#>

# Define the log file path
$logFilePath = "C:\temp\logs\time_sync.txt"

# Start a transcript to log the script's output
Start-Transcript -Path $logFilePath

# Initialize the exit code
$exitCode = 0

try {
    # Force NTP time synchronization
    Write-Host "[Info]Stopping time service..."
    Stop-Service -Name w32time
    Write-Host "[Info]Starting time service..."
    Start-Service -Name w32time

    Write-Host "[Info]w32tm resynchronization..."
    w32tm /resync
} catch {
    # If an error occurs, log the error message
    Write-Host "[Error]: $_"
    
    # Set a non-zero exit code to indicate an error
    $exitCode = 1
}

# Stop the transcript to finish logging
Stop-Transcript

# Exit with the specified exit code
Exit $exitCode
