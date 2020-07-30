# Import CSV with VM's names and 
# The CSV Contains 3 columns - Name, OSType, Environment (You can change it as well)
$vmFile = import-csv -Path ".\AllVirtualMachines.csv"
$ResourceGroup = '<ReasourceGroupName>'

ForEach($resource in $vmFile){
    
    # Tags array Initializing
    $tags = @{"OSType" = $resource.OSType; "Environment" = $resource.Environment}

    # Add & Update tags on Azure VMs
    $Cloudresource = Get-AzResource -Name $resource.'Name' -ResourceGroup $ResourceGroup
    Update-AzTag -ResourceId $Cloudresource.id -Tag $tags -Operation Merge
}