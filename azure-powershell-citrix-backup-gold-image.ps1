##################################################################################

# Variables

# Location
$location = 'australiaeast'

# Pre Environment
# Server1
# Server2

# Prod Environment
# Server1
# Server2

$ResourceGroupname = 'ResourceGroup1'
$VMname = 'Server1'

##################################################################################

# Login to Azure
$adminUPN="itsnoahscloud@hotmail.com"

$userCredential = Get-Credential -UserName $adminUPN -Message "Type the password."

connect-msolservice -Credential $userCredential

connect-azaccount

az login --tenant '0fc12953-xxxx-xxxx-xxxx-29eb6e8efde4'

# Get Subscription
get-azsubscription

# List Azure Accounts
az account list --output table

#########################################################

# Date
$date = Get-Date -format ddMMyyyy

# Snapshot Name
$SnapshotName = $vmname + "_" +"Snapshot" + "_" + $date

# Deallocate VM
stop-azvm -ResourceGroupName $resourcegroupname -name $vmname -force

# Get the VM
$vm = get-azvm -ResourceGroupName $resourcegroupname -Name $vmname

# Snapshot config
$snapshot = new-azsnapshotconfig -SourceUri $vm.storageprofile.osdisk.manageddisk.id -Location $location -CreateOption copy

# Snapshot
new-azsnapshot -snapshot $snapshot -snapshotname $SnapshotName -resourcegroupname $ResourceGroupname

# Start $VM
start-azvm -ResourceGroupName $resourcegroupname -name $vmname

# List Snapshot
get-azsnapshot -ResourceGroupName $ResourceGroupname | ft
