#flip / back to \ if fails
$datacenter = Read-Host "Datacenter name in source vCenter"
#$path = Read-Host "Enter Path to Save CSV: "
$path = "./csv/exported_folders.csv"

filter Get-FolderPath {
    $_ | Get-View | % {
        $row = "" | select Name, Path
        $row.Name = $_.Name

        $current = Get-View $_.Parent
        $path = $_.Name
        do {
            $parent = $current
            if($parent.Name -ne "vm"){$path = $parent.Name + "/" + $path}
            $current = Get-View $current.Parent
        } while ($current.Parent -ne $null)
        $row.Path = $path
        $row
    }
}

## Export all folders
$report = @()
$report = get-datacenter $datacenter -Server $sourceVI| Get-folder vm | get-folder | Get-Folderpath
        ##Replace the top level with vm
        foreach ($line in $report) {
        $line.Path = ($line.Path).Replace($datacenter + "/","/vm")
        }
$report | Export-Csv -path $path -NoTypeInformation