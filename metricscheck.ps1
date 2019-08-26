#>
$et = get-date
$st = $et.addminutes(-10)
$ErrorActionPreference = “SilentlyContinue”
# Login to Azure Account
try
{
Connect-AzAccount -ErrorAction Stop
}
catch
{
# The exception lands in [Microsoft.Azure.Commands.Common.Authentication.AadAuthenticationCanceledException]
Write-Host “User Cancelled The Authentication” -ForegroundColor Yellow
exit
}
# Prompting the user to select the subscription
Get-AzSubscription | Out-GridView -OutputMode Single -Title “Please select a subscription” | ForEach-Object {$selectedSubscriptionID = $PSItem.SubscriptionId}
Write-Host “You have selected the subscription: $selectedSubscriptionID. Proceeding with fetching the inventory. `n” -ForegroundColor green
# Setting the selected subscription
Select-AzSubscription -SubscriptionId $selectedSubscriptionID
# Get the list of resource groups
$resourcegroup_list = (get-azresourcegroup).resourcegroupname

foreach($resourcegroup_list_iterator in $resourcegroup_list){
#write-output “RG: ” $resourcegroup_list_iterator
$vm_list = get-azvm -ResourceGroupName $resourcegroup_list_iterator
foreach($vm_list_iterator in $vm_list){
write-host “Fetching performance metrics for the virtual machine: ” $vm_list_iterator.Name -ForegroundColor cyan
get-azmetric -ResourceId $vm_list_iterator.id -TimeGrain 00:01:00 -DetailedOutput -StartTime $st -EndTime $et -DetailedOutput -MetricName "Percentage CPU" # Percentage
get-azmetric -ResourceId $vm_list_iterator.id -TimeGrain 00:01:00 -DetailedOutput -StartTime $st -EndTime $et -MetricName “Network IN” # Bytes
get-azmetric -ResourceId $vm_list_iterator.id -TimeGrain 00:01:00 -DetailedOutput -StartTime $st -EndTime $et -MetricName “Network Out” # Bytes
get-azmetric -ResourceId $vm_list_iterator.id -TimeGrain 00:01:00 -DetailedOutput -StartTime $st -EndTime $et -MetricName “Disk Read Bytes” # Bytes Per Second
get-azmetric -ResourceId $vm_list_iterator.id -TimeGrain 00:01:00 -DetailedOutput -StartTime $st -EndTime $et -MetricName “Disk Write Bytes” # Bytes Per Second
get-azmetric -ResourceId $vm_list_iterator.id -TimeGrain 00:01:00 -DetailedOutput -StartTime $st -EndTime $et -MetricName “Disk Read Operations/Sec” # Count Per Second
get-azmetric -ResourceId $vm_list_iterator.id -TimeGrain 00:01:00 -DetailedOutput -StartTime $st -EndTime $et -MetricName “Disk Write Operations/Sec” # Count Per Second
}
Write-Output ””
} 


