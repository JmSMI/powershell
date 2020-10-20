#connect to exchange online module using EXOPSession in powershell
#this script will list all groups that all members are part of

[IO.Directory]::SetCurrentDirectory((Get-Location))

#List all Office365 Groups
$Groups = Get-UnifiedGroup -ResultSize Unlimited

#Create a new object to represent people
$Groups | ForEach-Object {
Get-UnifiedGroupLinks -Identity $_.Name -LinkType Members -ResultSize Unlimited | 
ForEach-Object {
       New-Object -TypeName PSObject -Property @{
        Group = $_.DisplayName
        Member = $_.Name
        EmailAddress = $_.PrimarySMTPAddress
        RecipientType= $_.RecipientType
}}} | Export-CSV -Path .\office365-groupParticipation.csv -NoTypeInformation -Encoding UTF8
