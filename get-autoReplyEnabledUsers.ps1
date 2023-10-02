<#
Get a list of all users who have an auto reply on or scheduled to be on
Author: James
Date: June 30 2020
Version 1.0

Requirements: Connect to Exchange Online Module for Office365
#>

# Replace <Company> with relevant string

get-user | Where-Object {($_.company -eq <Company>)} | 
Get-MailboxAutoReplyConfiguration | 
Where-Object {($_.Autoreplystate -eq "enabled") -or ($_.Autoreplystate -eq "scheduled")}  | 
Sort-Object -Property identity | Select-Object identity
