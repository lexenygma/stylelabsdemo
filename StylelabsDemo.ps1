# TODO add credential get here ->
$VMCredential = Get-Credential -Message 'Please enter the vm credentials'
$VMConfig | New-NetFirewallRule –DisplayName “Allow ICMPv4-In” –Protocol ICMPv4


#Create new resource group
New-AzResourceGroup -Name Demo -Location "West Europe"

#Create new virtual network 
$virtualNetwork = New-AzVirtualNetwork `
  -ResourceGroupName Demo `
  -Location westeurope `
  -Name DemoNetwork `
  -AddressPrefix 172.10.10.0/24

#Create new subnet 
$subnetConfig = Add-AzVirtualNetworkSubnetConfig `
  -Name DemoSubnet `
  -AddressPrefix 172.10.10.0/28 `
  -VirtualNetwork $virtualNetwork

#Associate subnet to virtual network 
$virtualNetwork | Set-AzVirtualNetwork `

#Create new network security group

#Create new public IP address

#Create new VM 1 
New-AzVm `
  -ResourceGroupName "Demo" `
  -Location "West Europe" `
  -VirtualNetworkName "DemoNetwork" `
  -SubnetName "DemoSubnet" `
  -Name "myVm1" `
  -Credential $VMCredential `
  -VM $VMConfig `
  -AsJob


#Create new VM 2
New-AzVm `
  -ResourceGroupName "Demo" `
  -Location "West Europe" `
  -VirtualNetworkName "DemoNetwork" `
  -SubnetName "DemoSubnet" `
  -Credential $VMCredential `
  -VM $VMConfig `
  -Name "myVm2" `