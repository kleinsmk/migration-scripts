$vms = Import-Csv -Path "./csv/vmx_locations.csv"

foreach($vm in $vms) {


    try{ 
            Remove-VM -VM $vm.Name -DeleteFromDisk:$false -Confirm:$false -RunAsync
            Write-Host "Unregistered " $vm.Name
    }

    catch{
            Write-Host "Error unregistering " + $vm.name
    }

}

