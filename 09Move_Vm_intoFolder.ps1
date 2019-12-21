
function Get-FolderByPath{
  <# .SYNOPSIS Retrieve folders by giving a path .DESCRIPTION The function will retrieve a folder by it's path. The path can contain any type of leave (folder or datacenter). .NOTES Author: Luc Dekens .PARAMETER Path The path to the folder. This is a required parameter. .PARAMETER Path The path to the folder. This is a required parameter. .PARAMETER Separator The character that is used to separate the leaves in the path. The default is '/' .EXAMPLE PS> Get-FolderByPath -Path "Folder1/Datacenter/Folder2"
.EXAMPLE
  PS> Get-FolderByPath -Path "Folder1>Folder2" -Separator '>'
#>
 
  param(
  [CmdletBinding()]
  [parameter(Mandatory = $true)]
  [System.String[]]${Path},
  [char]${Separator} = '/'
  )
 
  process{
    if((Get-PowerCLIConfiguration).DefaultVIServerMode -eq "Multiple"){
      $vcs = $defaultVIServers
    }
    else{
      $vcs = $defaultVIServers[0]
    }
 
    foreach($vc in $vcs){
      foreach($strPath in $Path){
        $root = Get-Folder -Name Datacenters -Server $vc
        $strPath.Split($Separator) | %{
          $root = Get-Inventory -Name $_ -Location $root -Server $vc -NoRecursion
          if((Get-Inventory -Location $root -NoRecursion | Select -ExpandProperty Name) -contains "vm"){
            $root = Get-Inventory -Name "vm" -Location $root -Server $vc -NoRecursion
          }
        }
        $root | where {$_ -is [VMware.VimAutomation.ViCore.Impl.V1.Inventory.FolderImpl]}|%{
          Get-Folder -Name $_.Name -Location $root.Parent -NoRecursion -Server $vc
        }
      }
    }
  }
}

$datacenter = Read-Host "Please enter datacenter name: "
$dc_path = Read-Host "Please enter starting Folder Path like ( Datacenter/CNSI ) without a trailing /"
$vms = Import-Csv -Path "./csv/vms_with_folder.csv"


foreach($vm in $vms){
    #for Datacenter without subfolders use "/',3  and [2]
    $folder_path = $vm.Path.Split("/",2)
    $folder_path = $dc_path + "/" + $folder_path[1]
	
	if ($vm.path -eq $datacenter) {
		$output += "Moved :" + $vm.Name + " " + $folder_path + "`n"
		Move-VM -VM (Get-VM $vm.Name) -Destination (Get-FolderByPath -Path $datacenter) -RunAsync
		}
	else
		{
        $output += "Moved " + $vm.Name + " " + $folder_path + "`n"
		Move-VM -VM (Get-VM $vm.Name) -Destination (Get-FolderByPath -Path $folder_path) -RunAsync
		}
}

$output
$output | Out-File -FilePath "./csv/moved_vm.csv"
