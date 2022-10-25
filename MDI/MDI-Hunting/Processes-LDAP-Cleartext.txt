// Processes who executed LDAP auth with cleartext for the last 31d
// Microsoft Sentinel Query - for Advanced Hunting (AH) see comments below
// Mixed two tables - IdentityLogonEvents & DeviceNetworkEvents
IdentityLogonEvents
| where TimeGenerated > ago(31d) // Timestamp for AH
| where LogonType == "LDAP cleartext" //and isnotempty(AccountName)
| project LogonTime = TimeGenerated, DeviceName, Application, ActionType, LogonType //,AccountName // Timestamp for AH
| join kind=inner (
DeviceNetworkEvents
| where TimeGenerated > ago(31d) | where ActionType == "ConnectionSuccess" // Timestamp for AH
| extend DeviceName = toupper(trim(@"..$",DeviceName))
| where RemotePort == 389 // RemotePort == "389" for AH
| project NetworkConnectionTime = TimeGenerated, DeviceName, AccountName = InitiatingProcessAccountName, InitiatingProcessFileName, InitiatingProcessCommandLine ) on DeviceName // Timestamp for AH
| where LogonTime - NetworkConnectionTime between (-2m .. 2m)
| project Application, LogonType, ActionType, LogonTime, DeviceName, InitiatingProcessFileName, InitiatingProcessCommandLine, AccountName
