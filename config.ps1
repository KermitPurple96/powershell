winget install JanDeDobbeleer.OhMyPosh -s winget
Install-Module -Name Terminal-Icons -Scope CurrentUser -Force
Install-Module -Name PSReadLine -Scope CurrentUser -Force
winget install Neovim.Neovim
Add-WindowsCapability -Online -Name OpenSSH.Client~~~~0.0.1.0
Add-WindowsCapability -Online -Name OpenSSH.Server~~~~0.0.1.0
Start-Service sshd
Set-Service -Name sshd -StartupType 'Automatic'
