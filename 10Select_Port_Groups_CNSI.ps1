$vms = Import-Csv -Path "./csv/portgroups.csv"

foreach ($vm in $vms ) {



    switch ($vm.network_name)
        {
            "61 Network"   { (Get-Vm -Name $vm.vmname | Get-NetworkAdapter -Name $vm.nic | Set-NetworkAdapter -NetworkName "Legacy|ACC|VLAN-61"   -confirm:$false -RunAsync ); Write-Host $vm.vmname "was set to" "Legacy|CNSI|VLAN-100"    }
            "68 Nework" { (Get-Vm -Name $vm.vmname | Get-NetworkAdapter -Name $vm.nic | Set-NetworkAdapter -NetworkName "Legacy|ACC|VLAN-68"  -confirm:$false -RunAsync); Write-Host $vm.vmname "was set to" "Legacy|CNSI|VLAN-1100"   }
            "61Net" { (Get-Vm -Name $vm.vmname | Get-NetworkAdapter -Name $vm.nic | Set-NetworkAdapter -NetworkName "Legacy|ACC|VLAN-61"  -confirm:$false -RunAsync); Write-Host $vm.vmname "was set to" "Legacy|CNSI|VLAN-1101"   }
            "71 Network" { (Get-Vm -Name $vm.vmname | Get-NetworkAdapter -Name $vm.nic | Set-NetworkAdapter -NetworkName "Legacy|CNSI|VLAN-15"  -confirm:$false -RunAsync); Write-Host $vm.vmname "was set to" "Legacy|CNSI|VLAN-1102"   }
            "69 Network" { (Get-Vm -Name $vm.vmname | Get-NetworkAdapter -Name $vm.nic | Set-NetworkAdapter -NetworkName "Legacy|CNSI|VLAN-69"  -confirm:$false -RunAsync); Write-Host $vm.vmname "was set to" "Legacy|CNSI|VLAN-1103"   }
            "64-67 Networks" { (Get-Vm -Name $vm.vmname | Get-NetworkAdapter -Name $vm.nic | Set-NetworkAdapter -NetworkName "Legacy|CNSI|VLAN-184"  -confirm:$false -RunAsync); Write-Host $vm.vmname "was set to" "Legacy|CNSI|VLAN-1104"   }
            "62 Network" { (Get-Vm -Name $vm.vmname | Get-NetworkAdapter -Name $vm.nic | Set-NetworkAdapter -NetworkName "Legacy|CNSI|VLAN-62"  -confirm:$false -RunAsync); Write-Host $vm.vmname "was set to" "Legacy|CNSI|VLAN-1105"   }
            "72 Network" { (Get-Vm -Name $vm.vmname | Get-NetworkAdapter -Name $vm.nic | Set-NetworkAdapter -NetworkName "Legacy|CNSI|VLAN-72"  -confirm:$false -RunAsync); Write-Host $vm.vmname "was set to" "Legacy|CNSI|VLAN-1106"   }
            "63 Network" { (Get-Vm -Name $vm.vmname | Get-NetworkAdapter -Name $vm.nic | Set-NetworkAdapter -NetworkName "Legacy|CNSI|VLAN-63"  -confirm:$false -RunAsync); Write-Host $vm.vmname "was set to" "Legacy|CNSI|VLAN-1106"   }
            default { "$vm did not have a port group match for: $vm.network_name" }
        }
        
         
}   


