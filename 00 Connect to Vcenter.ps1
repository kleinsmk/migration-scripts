Import-Module VMware.VimAutomation.Core

$vcenter = Read-Host "Please enter the Vcenter IP"
Connect-VIServer $vcenter