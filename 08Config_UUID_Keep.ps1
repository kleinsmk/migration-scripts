
$datacenter = Read-Host "DataCenter name in source vCenter #try Destination first actuall"
$folder = Read-Host "Please enter Folder name in source vCenter"

#need to adjust to only set value for new vms
#Sets the keep flag on all VM's vmx config file
Get-Datacenter $datacenter | Get-Folder $folder | Get-Vm | New-AdvancedSetting -Name "uuid.action" -value "keep" -Force:$true