#Connect to EXOP
$user = Get-Mailbox <String>
Get-InboxRule -Mailbox  $user

#Check each rule identity
Get-InboxRule -Mailbox $user -Identity <String>

Disable-InboxRule -Mailbox $user -Identity <String>
