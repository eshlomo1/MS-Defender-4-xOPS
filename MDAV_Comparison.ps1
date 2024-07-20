# Step 1: Retrieve the list of versions from the provided URI

$uri = "https://www.microsoft.com/security/encyclopedia/adlpackages.aspx?action=info"
$response = Invoke-RestMethod -Uri $uri
$versions = $response | Select-Object -ExpandProperty versions

# Step 2: Get the current Windows AV version installed on your system

$currentAVVersion = (Get-MpComputerStatus).AMProductVersion

# Step 3: Compare the current AV version with the retrieved versions

$matchFound = $false
foreach ($version in $versions) {
if ($currentAVVersion -eq $version) {
Write-Output "Match found: Current AV version ($currentAVVersion) matches version from server ($version)"
$matchFound = $true
}
}
if (-not $matchFound) {
Write-Output "No match found: Current AV version ($currentAVVersion) does not match any version from server."
}
