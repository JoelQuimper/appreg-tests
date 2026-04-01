### before running this, make sure to :
#    1- Set the context by running 0-Set-Context/Set-LocalDev.ps1 and filling in the required variables
#    2- Get an access token by running either 1-Get-Token/Get-DeviceCodeToken.ps1 or 1-Get-Token/Get-ClientCredToken.ps1

## read from Fabric WareHouse using SQLServer Powershell module
# requires the SqlServer module to be installed
# requires the following permissions:
# - user_impersonnation  

$warehouseServerAddress = Read-Host("`nPlease provide your datawarehouse server address ")
$warehouseDatabaseName = Read-Host("`nPlease provide your datawarehouse name ")
$sqlQuery = "SELECT TOP 10 * FROM dbo.table1"

$result = Invoke-Sqlcmd -ServerInstance $warehouseServerAddress -Database $warehouseDatabaseName -AccessToken $accessToken -Query $sqlQuery