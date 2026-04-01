### before running this, make sure to :
#    1- Set the context by running 0-Set-Context/Set-LocalDev.ps1 and filling in the required variables
#    2- Get an access token by running either 1-Get-Token/Get-DeviceCodeToken.ps1 or 1-Get-Token/Get-ClientCredToken.ps1

# create subscription to SharePoint audit logs
# see https://learn.microsoft.com/en-us/office/office-365-management-api/office-365-management-activity-api-reference

### Define webhook URL and AuthId
$webHookUrl = "<your-webhook-url>"
$authId = "<the-authid-used-to-validate-your-webhook>"
    
### Create subscription for SharePoint Audit logs
$subscriptionRequestParams = @{
    Method = 'POST'
    Uri    = "$baseUrl/start?contentType=Audit.SharePoint&PublisherIdentifier=$tenantId"
    Headers = @{
        Authorization = "Bearer $accessToken"
        "Content-Type"  = "application/json"
    }
    Body = @{
        webhook = @{
            address = $webHookUrl
            authId = $authId
        }
    } | ConvertTo-Json
}
$response = Invoke-RestMethod @subscriptionRequestParams
$response

### List existing subscriptions
$listSubscriptionsParams = @{
    Method = 'GET'
    Uri    = "$baseUrl/list?PublisherIdentifier=$tenantId"
    Headers = @{
        Authorization = "Bearer $accessToken"
        "Content-Type"  = "application/json"
    }
}
$response = Invoke-RestMethod @listSubscriptionsParams
$response

### Remove a subscription
$removeSubscriptionParams = @{
    Method = 'POST'
    Uri    = "$baseUrl/stop?contentType=Audit.SharePoint&PublisherIdentifier=$tenantId"
    Headers = @{
        Authorization = "Bearer $accessToken"
        "Content-Type"  = "application/json"
    }
}
$response = Invoke-RestMethod @removeSubscriptionParams
$response