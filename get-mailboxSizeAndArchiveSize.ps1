# Connect-EXOPSession

Get-Mailbox -resultsize Unlimited | Select-Object name,
@{n = "User ID"; e = {}},
@{n = "Primary Size"; e = {(Get-MailboxStatistics $_.identity).totalItemsize}},
@{n = "Primary Size (GB)"; e = {}},
@{n = "Primary Item Count"; e = {(Get-MailboxStatistics $_.identity).ItemCount}},
@{n = "Archive Size"; e = {(Get-MailboxStatistics -archive $_.identity).TotalItemSize}},
@{n = "Archive Size (GB)"; e = {}},
@{n = "Archive Item Count"; e = {(Get-MailboxStatistics -archive $_.identity).ItemCount}},
@{n = "Report Date"; e = {(Get-Date).Date}} | export-csv .\mailboxandarchivesizes.csv
