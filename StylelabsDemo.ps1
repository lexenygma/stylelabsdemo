# Script for creating a simple environment on Azure with x2 Windows machines.  

# Get-Credential
$VMCredential = Get-Credential -Message 'Please enter the vm credentials'

#Create new resource group
New-AzResourceGroup -Name Demo -Location "West Europe"

#Create new virtual network 
$virtualNetwork = New-AzVirtualNetwork `
  -ResourceGroupName Demo `
  -Location westeurope `
  -Name DemoNetwork `
  -AddressPrefix 172.10.10.0/24 `

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
  -AsJob


#Create new VM 2
New-AzVm `
  -ResourceGroupName "Demo" `
  -Location "West Europe" `
  -VirtualNetworkName "DemoNetwork" `
  -SubnetName "DemoSubnet" `
  -Credential $VMCredential `
  -Name "myVm2" `