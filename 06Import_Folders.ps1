
$datacenter = Read-Host "DataCenter name in vCenter"
$path = "./csv/exported_folders.csv"        
$start = Read-Host "Enter Folder to start from"


##IMPORT FOLDERS
$vmfolder = Import-Csv $path | Sort-Object -Property Path

foreach($folder in $VMfolder){
    $key = @()
    $key =  ($folder.Path -split "\\")[-2]
    if ($key -eq "vm") {
        get-datacenter $datacenter -Server $destVI | get-folder $start | New-Folder -Name $folder.Name
        } 
    else {
        get-datacenter $datacenter -Server $destVI | get-folder $start | get-folder $key | New-Folder -Name $folder.Name 
        }
}