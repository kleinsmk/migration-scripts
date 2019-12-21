function Get-VMXPath {  
#Requires -Version 2.0  
[CmdletBinding()]  
 Param   
   (  
    [Parameter(Mandatory=$true,  
               Position=1,  
               ValueFromPipeline=$true,  
               ValueFromPipelineByPropertyName=$true)]  
    [String[]]$Name     
   )#End Param   
  
Begin  
{  
 Write-Verbose "Retrieving VMX Path Info . . ."  
}#Begin  
Process  
{  
    try  
        {  
            Get-VM -Name $Name | 
            Add-Member -MemberType ScriptProperty -Name 'VMXPath' -Value {$this.extensiondata.config.files.vmpathname} -Passthru -Force | 
            Select-Object Name,VMXPath
        }  
    catch  
        {  
            "Error: You must connect to vCenter first." | Out-host  
        }  
         
}#Process  
End  
{  
  
}#End  
  
}#Get-VMXPath 

#$path = Read-Host "Enter Path and name to save csv"

#Get-VM | Get-VMXPath | Export-Csv -Path $path -NoTypeInformation

Get-VM | Get-VMXPath | Export-Csv -Path "./csv/vmx_locations.csv" -NoTypeInformation

