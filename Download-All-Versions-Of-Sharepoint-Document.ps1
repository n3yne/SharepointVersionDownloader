#Set Parameters
if ($args.count -eq 0) {
	$FullURL = Read-Host -Prompt "Please enter the full URL of the file"
} else {
	$FullURL = $args[0]
}

$temp1,$temp2,$temp3,$temp4,$temp5,$remainder = $FullURL -split '/',6
$SiteURL = $temp1 + "/" + $temp2 + "/" + $temp3 + "/" + $temp4 + "/" + $temp5 + "/"
$null,$remainder2 = $remainder -split '\?',2
$null,$null,$null,$remainder3 = $remainder2 -split '/',4
$FileRelativeURL,$null = $remainder3 -split '\&',2
$FileRelativeURL = [uri]::UnescapeDataString($FileRelativeURL)

if ($args.count -le 1) {
	$DownloadPath = Read-Host -Prompt "Please enter the full path where you wish to download the versions"
} else {
	$DownloadPath = $args[1]
}
 
 
#Install PnP Online if needed
if (-not $(get-command Connect-PnPOnline -errorAction SilentlyContinue)) {
	"Installing PnP Online PowerShell Module..."
	Install-Module -Name PnP.PowerShell -AcceptLicense -Confirm:$false -Force
}
if (-not $(get-command Connect-PnPOnline -errorAction SilentlyContinue)) {
	"Could not install PnP Online PowerShell Module. Contact IT for assistance"
	"Aborting..."
	exit 1
}

#Connect to PnP Online
Connect-PnPOnline -Url $SiteURL -Interactive -ForceAuthentication
$Ctx = Get-PnPContext
 
#Get the File
$File = Get-PnPFile -Url $FileRelativeURL
 
#Get File Versions
$FileVersions = Get-PnPProperty -ClientObject $File -Property Versions
 
If (-not $(Test-Path $DownloadPath)) {
	New-Item -Path $DownloadPath -ItemType "directory" | Out-Null
}
 
If($FileVersions.Count -gt 0)
{
    Foreach($Version in $FileVersions)
    {
        #Frame File Name for the Version
        $VersionFileName = "$($DownloadPath)\$($Version.VersionLabel)_$($File.Name)"
          
        #Get Contents of the File Version
        $VersionStream = $Version.OpenBinaryStream()
        $Ctx.ExecuteQuery()
  
        #Download File version to local disk
        [System.IO.FileStream] $FileStream = [System.IO.File]::Open($VersionFileName,[System.IO.FileMode]::OpenOrCreate)
        $VersionStream.Value.CopyTo($FileStream)
        $FileStream.Close()
          
        Write-Host -f Green "Version $($Version.VersionLabel) Downloaded to :" $VersionFileName
    }
}
Else
{
    Write-host -f Yellow "No Versions Found!"
}

start $DownloadPath