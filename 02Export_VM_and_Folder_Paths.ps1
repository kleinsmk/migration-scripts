
$datacenter = Read-Host "DataCenter name in source vCenter"


filter Get-FolderPath {
    $_ | Get-View | % {
        $row = "" | select Name, Path
        $row.Name = $_.Name

        $current = Get-View $_.Parent
        $path = ""
        do {
            $parent = $current
            if($parent.Name -ne "vm"){$path = $parent.Name + "/" + $path}
            $current = Get-View $current.Parent
        } while ($current.Parent -ne $null)
        $path = $path.Substring(0,$path.Length-1)
        $row.Path = $path
        $row
    }
}


##Export all VM locations
$report = @()
$report = get-datacenter $datacenter | get-vm | Get-Folderpath
$report | Export-Csv "./csv/vms_with_folder.csv" -NoTypeInformation