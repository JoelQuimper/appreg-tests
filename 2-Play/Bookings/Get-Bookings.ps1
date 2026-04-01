### before running this, make sure to :
#    1- Set the context by running 0-Set-Context/Set-LocalDev.ps1 and filling in the required variables
#    2- Get an access token by running either 1-Get-Token/Get-DeviceCodeToken.ps1 or 1-Get-Token/Get-ClientCredToken.ps1

### retrieve users using the graph via a rest request
# requires having the following permissions:
# - for device code flow - Bookings.Read.All (Delegated)
# - for client credentials flow - Bookings.Read.All (Application)

$uri = "$baseUrl/solutions/bookingBusinesses"
$headers = @{
    Authorization = "Bearer $accessToken"
}
$bookings = Invoke-RestMethod -Uri $uri -Headers $headers -Method Get

# display booking details including staff
$bookings.value | ForEach-Object {
    Write-Output ("Booking id: " + $_.id)
    Write-Output ("Booking name: " + $_.displayName)
    # display booking details including staff
    $bookingUri = "$baseUrl/solutions/bookingBusinesses/" + $_.id
    $booking = Invoke-RestMethod -Uri $bookingUri -Headers $headers -Method Get
    Write-Output ("Booking created: " + $booking.createdDateTime)
    Write-Output ("Booking lastUpdated: " + $booking.lastUpdatedDateTime)
    Write-Output ("Booking isPublished: " + $booking.isPublished)
    Write-Output ("Booking email: " + $booking.email)

    $staffUri = "$baseUrl/solutions/bookingBusinesses/" + $_.id + "/staffMembers"
    $staff = Invoke-RestMethod -Uri $staffUri -Headers $headers -Method Get
    $staff.value | ForEach-Object {
        Write-Output ("Staff: " + $_.id)
        Write-Output ("Staff: " + $_.displayName)
    }
}

    
