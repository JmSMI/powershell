<#
Opt out of Cortana Briefing email for all active users in tenant
Date: June 30 2020
Requirements:
    InstallModule ExchangeOnlineManagement
    Connect to Exchange Online

#>
Get-User | Where-Object {$_.Company -eq "David Suzuki Foundation"} |
    ForEach-Object
    {
        get-UserBriefingConfig -Identity $_.windowsemailaddress -ea 0
    } |
Where-Object {$_.isEnabled -eq $true} |
    ForEach-Object
    {
        Set-UserBriefingConfig -Identity $_.userid -Enabled $false
    }
