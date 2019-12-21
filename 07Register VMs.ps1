$vms = Import-Csv -Path "C:\csv\vmx_locations.csv"

$vmhost = Read-Host "Enter target host ESXi name: "

$vmhost = Get-VMHost -name $vmhost

foreach($vm in $vms) {


    try{ 
            New-Vm -VMFilePath $vm.VMXPath -Name $vm.Name -VMHost $vmhost -RunAsync
            Write-Host "Registered " $vm.Name
    }

    catch{
            Write-Host "Error registering " + $vm.name
            

    }

}


