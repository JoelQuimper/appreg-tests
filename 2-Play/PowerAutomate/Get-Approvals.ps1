### before running this, make sure to :
#    1- Set the context by running 0-Set-Context/Set-LocalDev.ps1 and filling in the required variables
#    2- Get an access token by running either 1-Get-Token/Get-DeviceCodeToken.ps1 or 1-Get-Token/Get-ClientCredToken.ps1

$headers = @{
    Authorization = "Bearer $accessToken"
}

# get list of all approvals
$environmentId = "Default-..."
$ownerId = "user-object-id" # user object id of the approval owner
$uri = "$baseUrl/$environmentId/approvals?`$filter=properties/owner/id eq '$ownerId'"

$approvals = Invoke-RestMethod -Uri $uri -Headers $headers -Method Get
$approvals.value | ForEach-Object {
    $approval = $_
    Write-Host "Approval ID: $($approval.name)"
    Write-Host "Title: $($approval.properties.title)"
    Write-Host "Status: $($approval.properties.status)"
    Write-Host "Created Time: $($approval.properties.creationDate)"
    Write-Host "Owner: $($approval.properties.owner.userPrincipalName)"
    Write-Host "Owner name: $($approval.properties.owner.displayName)"
    Write-Host "-----------------------------"
}  