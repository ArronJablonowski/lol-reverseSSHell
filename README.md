# lol-reverseSSHell
Windows OS reverse shell over SSH

This script will install OpenSSH on Windows 10 via WindowsCapability. Copy the SSH private key and authorized_keys file to the proper locations on the Windows host. Then create a reverse SSH connection. The shell serves CMD.exe by default. Once you're in the cmd cli, you can type 'powershell' to get a PS shell. 

Usage: 
*Please generate your OWN SSH KEYs. Use the repo keys only for testing. 
1. Generate SSH keypair (A) and name them winkey & winkey.pub. Then replace default SSH keys in repo. 
2. Generate SSH keypair (B) and add the Public Key to the "authorized_keys" file in repo. Private key (B) is placed on destination host. 
3. Add winkey.pub (A) to the destination host's authorized_keys file, so SSH can connect outbound to the destination host. 
