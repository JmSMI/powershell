<#
Get a list of all users who have an auto reply on or scheduled to be on
Author: James
Date: June 30 2020
Version 1.0

Requirements: Connect to Exchange Online Module for Office365
#>
get-user | Where-Object {($_.company -eq "David Suzuki Foundation")} | 
Get-MailboxAutoReplyConfiguration | 
Where-Object {($_.Autoreplystate -eq "enabled") -or ($_.Autoreplystate -eq "scheduled")}  | 
Sort-Object -Property identity | Select-Object identity
