$vms = Get-VM

$results = @()                         

foreach ($vm in $vms){

    $nics = $vm | Get-NetworkAdapter

    foreach ($nic in $nics) {
        
        #create a custom object
        $networks = New-Object PSObject -Property @{            
        vmname           = $vm.name
        nic              = $nic.Name  
        network_name     = $nic.NetworkName
                            
        } 

        $results += $networks
        Remove-Variable networks    
    }
}

$results | Select-Object vmname, nic, network_name | Sort-Object vmname | Export-Csv -Path "./csv/portgroups.csv" -NoTypeInformation

# get-vm $vm | Get-NetworkAdapter | Set-NetworkAdapter -NetworkName $newnet -Confirm:$false
        