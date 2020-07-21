#Connect to EXOP
$user = Get-Mailbox <String>
Get-InboxRule -Mailbox  $user

#Check each rule identity
Get-InboxRule -Mailbox $user -Identity <String>

Disable-InboxRule -Mailbox $user -Identity <String>

$Recipient = Read-Host -Prompt "Enter the recipient email address to check recently sent mail"

#Review recent messages sent
Get-MessageTrace  -Recipient $Recipient -StartDate (get-date).adddays(-10) -EndDate (get-date)
