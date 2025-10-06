## set variables (use Set-LocalDev.ps1 to set these variables)
# redirect-url must be set to same value in the app registration
$redirectUrl = "http://localhost:3000" # redirect URL for the app registration


# https://msendpointmgr.com/2025/02/23/understanding-oauth-coding-the-authentication-flow-yourself-vs-using-an-sdk/


# todo

### add token to clipboard to inspect in jwt.ms
$accessToken | Set-Clipboard
