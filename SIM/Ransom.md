# Ransomware Simulator to encrypt or decrypt files at a given path recursivelygiven path
 
 This script iso be used to test your defenses and backups against ransomware in a controlled environment. 
 You can encrypt fake data for your simulation, but you also have the option to decrypt the files with the same script if you need to.
 
## Ransomware building blocks

Ransomware is a piece of software that generally implements the following techniques in order:

1. Initial access can be done in multiple ways. Usually, phishing, leveraging valid accounts on externally open services or exploiting public-facing services.
2. Execute code execution tactic, usually leveraging multiple techniques to evade detection.
3. Optional - injects code into a trust, ed context such as a system service.
4. Optional - disable the existing security software.
5. Discover existing drives, removable media, shared drives, and shares.
6. Optional - laterally move to other hosts and infect them with the same ransomware code. This is usually done by leveraging exploits and stealing creds.
7. Deletes existing backups to hinder recovery.
8. Enumerates existing files by iterating over all discovered resources, encrypting every file the author deemed relevant. Sometimes, based on specific extensions, some folders are excluded, and sometimes only specific folders are encrypted. 
9. Optional - send original file content before the encryption for an increased ransom potential.
10. Opens a C2 channel and sends a message to the attacker with the host details & encryption key 
11. Drops a visible ransom note. 
12. Optional - modifying browser homepage, desktop wallpaper, and more

### Ransomware Simulation 
[RansomSIM - Ransomware simulation.](https://github.com/eshlomo1/MS-Defender-4-xOPS/tree/main/SIM/Ransom)

![](https://github.com/eshlomo1/MS-Defender-4-xOPS/blob/main/SIM/Ransom.png)
