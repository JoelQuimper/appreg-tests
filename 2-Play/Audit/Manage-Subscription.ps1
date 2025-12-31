# create subscription to SharePoint audit logs
# require an access token with Manage Office scope
# Set-LocalDev.ps1 must be used to set the required variables: $tenantId, $clientId, $clientSecret
# Token must be acquire first using an option in 1-Get-Token folder.  The variable $accessToken must contain the token.
# see https://learn.microsoft.com/en-us/office/office-365-management-api/office-365-management-activity-api-reference

### Define base URI, webhook URL and AuthId
$baseUri = "https://manage.office.com/api/v1.0/$tenantId/activity/feed/subscriptions"
$webHookUrl = "<your-webhook-url>"
$authId = "<the-authid-used-to-validate-your-webhook>"

### Create subscription for SharePoint Audit logs
$subscriptionRequestParams = @{
    Method = 'POST'
    Uri    = "$baseUri/start?contentType=Audit.SharePoint&PublisherIdentifier=$tenantId"
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
    Uri    = "$baseUri/list?PublisherIdentifier=$tenantId"
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
    Uri    = "$baseUri/stop?contentType=Audit.SharePoint&PublisherIdentifier=$tenantId"
    Headers = @{
        Authorization = "Bearer $accessToken"
        "Content-Type"  = "application/json"
    }
}
$response = Invoke-RestMethod @removeSubscriptionParams
$response