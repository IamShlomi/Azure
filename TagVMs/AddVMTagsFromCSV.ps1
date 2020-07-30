$vmFile = import-csv -Path "C:\Users\User\Desktop\IML-Local\Cloud Update Management\Azure\IML-Azure VMs-test.csv"
$ResourceGroup = 'production-network_rg'

ForEach($resource in $vmFile){

    $tags = @{"Application" = $resource.Application; "OSType" = $resource.OSType; "Environment" = $resource.Environment; "Role" = $resource.Role; "Stack" = $resource.'Stack'; "PCI" = $resource.'PCI'}

    $Cloudresource = Get-AzResource -Name $resource.'Name' -ResourceGroup $ResourceGroup
    Update-AzTag -ResourceId $Cloudresource.id -Tag $tags -Operation Merge
}
