$headers = @{
    Authorization = "Bearer $accessToken"
}

# get list of all approvals
$environmentId = "Default-..."
$ownerId = "user-object-id" # user object id of the approval owner
$uri = "$powerAutomateBaseUrl/$environmentId/approvals?`$filter=properties/owner/id eq '$ownerId'"

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