### before running this, make sure to :
#    1- Set the context by running 0-Set-Context/Set-LocalDev.ps1 and filling in the required variables
#    2- Get an access token by running either 1-Get-Token/Get-DeviceCodeToken.ps1 or 1-Get-Token/Get-ClientCredToken.ps1

### retrieve the lineage of a dataset using the Graph API via a REST request
# requires having the following permissions: 
# tenant.read.all, workspace.read.all


$headers = @{
    Authorization = "Bearer $accessToken"
}


# get list of all workspaces
$uri = "$baseUrl/admin/workspaces/modified"
$workspaces = Invoke-RestMethod -Uri $uri -Headers $headers -Method Get
$workspaces

# trigger scan for workspace information including lineage and datasource details (max 100 workspaces at a time)
$uri = "$baseUrl/admin/workspaces/getInfo"
$body = @{
    workspaces = $workspaces.id
    lineage = $true
    datasourceDetails = $true
}
$jsonBody = $body | ConvertTo-Json
$result = Invoke-RestMethod -Uri $uri -Headers $headers -Method POST -Body $jsonBody -ContentType "application/json"
$result

# get scan status for the workspace information scan
$uri = "$baseUrl/admin/workspaces/scanStatus/$($result.id)"
# call and wait for the scan to complete
while ($scanStatus.status -ne "Succeeded") {
    Start-Sleep -Seconds 10
    $scanStatus = Invoke-RestMethod -Uri $uri -Headers $headers -Method Get
    Write-Host "Current scan status: $($scanStatus.status)"
}

# get scan result for the workspace information scan - must wait Succeeded status from previous step
$uri = "$baseUrl/admin/workspaces/scanResult/$($scanStatus.id)"
$scanResult = Invoke-RestMethod -Uri $uri -Headers $headers -Method Get
$scanResult
#export all as json content
$scanResult | ConvertTo-Json -Depth 10 | Out-File -FilePath "C:\temp\scanResult.json" -Encoding utf8