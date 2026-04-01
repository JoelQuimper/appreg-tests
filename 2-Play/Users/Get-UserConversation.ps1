### before running this, make sure to :
#    1- Set the context by running 0-Set-Context/Set-LocalDev.ps1 and filling in the required variables
#    2- Get an access token by running either 1-Get-Token/Get-DeviceCodeToken.ps1 or 1-Get-Token/Get-ClientCredToken.ps1

### retrieve user conversations using the graph via a rest request

$userId = "..." # user object id of the user whose conversations we want to retrieve
$uri = "$baseUrl/users/$userId/chats"
$headers = @{
    Authorization = "Bearer $accessToken"
}
$conversations = Invoke-RestMethod -Uri $uri -Headers $headers -Method Get

# display conversations
$conversations.value | ForEach-Object {
    Write-Output "-----------------------------"
    Write-Output ($_ | ConvertTo-Json -Depth 3)
}