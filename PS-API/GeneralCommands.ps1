# Microsoft Graph API Using PowerShell
## How To Connect To Microsoft Graph API Using PowerShell

# Connect MG
Install-Module Microsoft.Graph -Scope AllUsers -Force

# Disconnect MG Session
Disconnect-MgGraph

# Retrieve any incident and alerts

Get-MgSecurityAlert | fl Title, Status, Id

Get-MgSecurityIncident | Select Id, DisplayName,Determination

Get-MgSecurityIncident | ? {$_.Status -eq "Active"}

# Export result to Grid View

Get-MgSecurityAlert | `
  Select-Object `
  Title, `
  Description, `
  Category, Id | `
  Out-GridView

# Connect to MG with specific Scope

Connect-MgGraph -Scopes `
        "SecurityActions.ReadWrite.All",`
        "SecurityEvents.ReadWrite.All",`
        "Policy.Read.All",`
        "Application.ReadWrite.All",`
        "User.Read.all",`
        "Application.Read.All",`
        "SecurityIncident.Read.All",`
        "SecurityIncident.ReadWrite.All",`
        "Directory.Read.All"     
        
# Filter specific value

Get-MgSecurityAlert | `
    Select-Object Title, Description, Category 
            $graphversion = "beta"
            $url = "https://graph.microsoft.com"
            $endpoint = "security/alerts"
            $filter = "title eq 'Account enumeration reconnaissance'"
            $body = @{}          
            $uri = "$url/$graphversion/$endpoint"             
            $alerts = Invoke-MgGraphRequest -Uri $uri -Method GET -Body $body

# Bulk update all alerts

            $alertid = Get-MgSecurityAlert | where-object {$_.AssignedTo -eq 'Unassigned'}
            $params = @{
                Comments = @(
                    "Case is closed"
                )
                Status = "resolved"
                VendorInformation = @{
                    Provider = "Azure Advanced Threat Protection"                    
                    SubProvider = "Azure Advanced Threat Protection"
                    Vendor = "Microsoft"
                }
            }
            foreach ($alert in $alertid)
            {
            $alert.id|Out-String
            Update-MgSecurityAlert -AlertId ($alert).ID -BodyParameter $params
            }
