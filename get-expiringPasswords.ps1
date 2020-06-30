<#
#requires -Module ActiveDirectory
#requires -RunAsAdministrator
 
 
.SYNOPSIS
    Checks to see if the account is X days within password expiration.
    For updated help and examples refer to -Online version.
  
.DESCRIPTION
    In this example if the $emailDate is set to -80 and $expiredDate is set to -90 it will show all users whos passwords are within 10 days of expiration.
    For updated help and examples refer to -Online version.
  
.NOTES
    Name: Get-PasswordExpiredUsers.ps1
    Version: 1.0
    Author: The Sysadmin Channel
    Date of last revision: 3/18/2017
  
.LINK
    https://thesysadminchannel.com/powershell-script-check-password-expirations-in-active-directory -
 
#>
 
Import-Module ActiveDirectory
 
#Set the number of days within expiration.  This will start to send the email x number of days before it is expired.
$DaysWithinExpiration = 10
 
#Set the days where the password is already expired and needs to change. -- Do Not Modify --
$MaxPwdAge   = (Get-ADDefaultDomainPasswordPolicy).MaxPasswordAge.Days
$expiredDate = (Get-Date).addDays(-$MaxPwdAge)
 
#Set the number of days until you would like to begin notifing the users. -- Do Not Modify --
$emailDate = (Get-Date).addDays(-($MaxPwdAge - $DaysWithinExpiration))
 
#Filters for all users who's password is within $date of expiration.
$ExpiredUsers = Get-ADUser -Filter {(PasswordLastSet -lt $emailDate) -and (PasswordLastSet -gt $expiredDate) -and (PasswordNeverExpires -eq $false) -and (Enabled -eq $true)} -Properties PasswordNeverExpires, PasswordLastSet, Mail | select samaccountname, PasswordLastSet, @{name = "DaysUntilExpired"; Expression = {$_.PasswordLastSet - $ExpiredDate | select -ExpandProperty Days}}, @{name = "EmailAddress"; Expression = {$_.mail}} | Sort-Object PasswordLastSet
 
$ExpiredUsers
