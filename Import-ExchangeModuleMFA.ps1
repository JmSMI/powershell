#Author: Microsoft
#Use this block if you need to make scripts that interact with Exchange Online

#This script will let you interact with Exchange online in an editor
$module = ((Get-ChildItem -Path $($env:LOCALAPPDATA + "\Apps\2.0\") `
    -Filter Microsoft.Exchange.Management.ExoPowershellModule.dll -Recurse).FullName | 
    Select-Object -Last 1)
Import-Module $module
$session = New-ExoPSSession
Import-PSSession $session
