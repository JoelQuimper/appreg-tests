<#
.SYNOPSIS
    Intentional importation of PowerShell modules and environment configuration.

.DESCRIPTION
    This script is used only when in development mode.

    Since modules can vary depending on deployments and environments, 
    I prefer to import and load them manually, similar to using 
    NuGet packages in C#. This ensures that necessary modules are 
    explicitly declared and imported, thus reducing the risk of conflicts or 
    missing dependencies.

    ** Modules must be saved locally beforehand using Save-Module.

.NOTES
    Author: Joël Quimper
    Date: 2026-04-01
#>
## Definition of variables for the app registration to use
$tenantId = "your-tenant-id"
$clientId = "your-client-id"
$clientSecret = "your-client-secret"

## Information about the target APIs
# Graph API
$baseUrl = "https://graph.microsoft.com/v1.0"
$scope = "https://graph.microsoft.com/.default"

# Power BI API
$baseUrl = "https://api.powerbi.com/v1.0/myorg"
$scope = "https://analysis.windows.net/powerbi/api/.default"

# Power Automate API
$baseUrl = "https://api.flow.microsoft.com/providers/Microsoft.ProcessSimple/environments"
$scope = "https://service.flow.microsoft.com/.default"

# M365 Audit API
$baseUrl = "https://manage.office.com/api/v1.0/$tenantId/activity/feed/subscriptions"
$scope = "https://manage.office.com/.default"

# For SQL Database
$baseUrl = "not set as I was using the SQL Powershell Module"
$scope = "https://database.windows.net/.default"

