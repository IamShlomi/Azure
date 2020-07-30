# Start VMs Script

# Ensures you do not inherit an AzContext in your runbook
Disable-AzContextAutosave –Scope Process

# Connect to Automation Account & Set parameters
$Conn = Get-AutomationConnection -Name AzureRunAsConnection
Connect-AzAccount -ServicePrincipal -Tenant $Conn.TenantID -ApplicationId $Conn.ApplicationID -CertificateThumbprint $Conn.CertificateThumbprint
$AzureContext = Select-AzSubscription -SubscriptionId $Conn.SubscriptionID
$resources = Get-AzVM

# Start VM Action for Patch Management Pool #1
foreach ($r in $resources){
    if ($r.Tags.PatchManagementPool -Like '1'){
        Start-AzVM -Name $r.'Name' -ResourceGroupName '<ResourceGroupName>' -AzContext $AzureContext
    }
}

#################################################################################

# Stop VMs Script

# Ensures you do not inherit an AzContext in your runbook
Disable-AzContextAutosave –Scope Process

# Connect to Automation Account & Set parameters
$Conn = Get-AutomationConnection -Name AzureRunAsConnection
Connect-AzAccount -ServicePrincipal -Tenant $Conn.TenantID -ApplicationId $Conn.ApplicationID -CertificateThumbprint $Conn.CertificateThumbprint
$AzureContext = Select-AzSubscription -SubscriptionId $Conn.SubscriptionID
$resources = Get-AzVM

# Stop VM Action for Patch Management Pool #1
foreach ($r in $resources){
    if ($r.Tags.PatchManagementPool -Like '1'){
        Stop-AzVM -Name $r.'Name' -ResourceGroupName '<ResourceGroupName>' -force
    }
}