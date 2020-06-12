<#
"Show-TopCPUProcs.ps1"
Calculates the average CPU usage for top three longest running
processes by dividing the total CPU time over the total duration 
of each
Author: James
Version: 1
Date: June 11 2020
#>

Write-Host "CPU% Process `n `r---- --------"
Get-Process | Where-Object {$_.TotalProcessorTime -gt 0} | 
Sort-Object -Property TotalProcessorTime | Select-Object -last 3 | 
ForEach-Object {$avgCpu = ($_.TotalProcessorTime.TotalSeconds / `
    ((get-date) - ($_.StartTime)).TotalSeconds)  
Write-host $($avgcpu).ToString("P2") "$($_.Name)" }


Get-Process | Where-Object {$_.TotalProcessorTime -gt 0} | 
Sort-Object -Property TotalProcessorTime | 
Select-Object -last 3 | 
ForEach-Object {$cpu = (((get-date) - $_.StartTime).Days)
Write-host "$($_.Name)" "$($cpu)`%"}

(Get-DAte).toString("HH:mm:ss.fffffff")