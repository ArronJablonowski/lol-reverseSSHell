# lol-reverseSSHell
Living Off the LAN Reverse Shell over SSH for Windows 10

This script will install OpenSSH on Windows 10 via WindowsCapability. Then it will copy the sshd_config file, SSH private key, and authorized_keys file to the proper locations on the Windows host. Finally it creates a reverse SSH connection. The shell serves CMD.exe by default. Once you're in the cmd cli, you can type 'powershell' to get a PS shell. 

* Please generate NEW SSH KEYs. Use the repo keys only for testing. 

Usage: 
1. Generate SSH keypair (A) and name them winkey & winkey.pub. Blank/No password for this keypair. Then replace default SSH keys in repo.
2. Add winkey.pub (A) to the authorized_keys file on the destination host receiving the SSH connection so SSH can connect outbound to the destination host. 
3. Generate another SSH keypair (B) and add the Public Key to the "authorized_keys" file in repo. Private key (B) is placed on destination host.
4. Modify the destination Host IP, User, and Port number at the top of the ./LoL-ReverseSSHell.ps1 script. 
5. From an elevated (admin) Powershell prompt run ./LoL-ReverseSSHell.ps1
 

![alt text](https://github.com/ArronJablonowski/lol-reverseSSHell/blob/main/image.png?raw=true)

