#Sample Script BCIT Comp3771
#Files created before this date will be copied
$date = [datetime]"June 2 2020"

#Create a Copies folder in case one doesn't exist
New-Item -Type Directory -Name "Copies" -ErrorAction 0

#Leave a starting message on the console
Write-Host "Saving the following files to the ""Copies"" folder" `n

#Get all files OLDER than $date
Get-ChildItem ../jamesMoffat/Downloads | Where-Object {$_.LastWriteTime -lt $date} |
ForEach-Object {
    $filescopied++;
    $totalsize += $_.Length;
    $name = [IO.Path]::GetFileNameWithoutExtension($_.Name) #Use IO.Path to split filename
    $extension = [IO.Path]::GetExtension($_.Name)           #Use IO.Path to split filename
    $newfilename = $name + "_" + $_.LastWriteTime.ToString("yyyy-MM-dd") + $extension #Recombine filename

    #Leave progress message on the console
    Write-Host "File #$($filescopied):" `n "        Copies/$newfilename"

    #copy each matching file
    Copy-Item $_ -Destination ./Copies/$newfilename}

#Provide summary statistics
Write-Host `n" Files Copied: " $FilesCopied `n "Total Size: " `
$totalsize.ToString("N0") "bytes"


