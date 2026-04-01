### before running this, make sure to :
#    1- Set the context by running 0-Set-Context/Set-LocalDev.ps1 and filling in the required variables
#    2- Get an access token by running either 1-Get-Token/Get-DeviceCodeToken.ps1 or 1-Get-Token/Get-ClientCredToken.ps1

### retrieve users using the graph via a rest request
# requires having the following permissions:
# - for device code flow - User.Read.All (Delegated)
# - for client credentials flow - User.Read.All (Application)

$uri = "$baseUrl/users"
$headers = @{
    Authorization = "Bearer $accessToken"
}
$users = Invoke-RestMethod -Uri $uri -Headers $headers -Method Get

# display users
$users.value | ForEach-Object {
    Write-Output ("User: " + $_.displayName)
}