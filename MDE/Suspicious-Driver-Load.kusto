// MDE Under the Hood
// Suspicious Driver Load with Time conditions and Prevalence - Based on DeviceEvents and DeviceFileCertificateInfo
DeviceEvents
| where ActionType == "DriverLoad"
| where Timestamp >= ago(31d)
| distinct SHA1 
| join kind=inner
    (
    DeviceFileCertificateInfo // Get the files having certificate older than todatetime or CertificateExpirationTime
    | where CertificateCreationTime < todatetime("7/30/2020") or CertificateExpirationTime < todatetime("7/30/2020")
    ) on SHA1 // Use prevalence when you've malicious driver
    | summarize dcount(DeviceId) by SHA1
    | where dcount_DeviceId <= 1 
    | invoke FileProfile(SHA1,1000) 
    | where GlobalPrevalence <= 300 //Files with Prevalence 
    | join DeviceFileCertificateInfo on SHA1 // Certificate details
