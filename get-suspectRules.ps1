
$recipient = "kietlamfecebook@gmail.com"

$users = (((Get-MessageTrace -RecipientAddress $recipient -StartDate $start -EndDate (get-date)).senderaddress |
Get-Mailbox -ErrorAction 0).alias | 
Select-Object -Unique)

$rules = foreach ($user in $users) {
    Get-InboxRule -mailbox $user} 

$rules | ft mailboxownerid, redirectto
