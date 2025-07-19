oh-my-posh init pwsh --config "$env:POSH_THEMES_PATH\ys.omp.json" | Invoke-Expression


#aliases
New-Alias -Name np -Value "C:\cmd\Notepad++.lnk" -Force

# https://raw.githubusercontent.com/JanDeDobbeleer/oh-my-posh/main/themes/clean-detailed.omp.json
#Prompt
oh-my-posh init pwsh --config 'C:\Users\jaime\Documents\PowerShell\myprofile.omp.json' | Invoke-Expression

Import-module NtObjectManager
Import-Module Terminal-Icons
Import-Module PSReadLine
Set-PSReadLineKeyHandler -Key Tab -Function Complete
Set-PSReadLineOption -PredictionViewStyle ListView

$originalPath = [System.Environment]::GetEnvironmentVariable("PATH", [System.EnvironmentVariableTarget]::User)

# Agregar tus nuevas rutas al PATH
$Variable_Name = "C:\cmd\nvim-win64\bin"
[Environment]::SetEnvironmentVariable("PATH", "$originalPath;$Variable_Name", [System.EnvironmentVariableTarget]::User)

Write-Host "`t Go modules:" -NoNewline
Write-Host "`t cd `$env:modules `n" -ForegroundColor Red

Write-Host "`t Go profile:" -NoNewline
Write-Host "`t cd `$env:profile `n" -ForegroundColor Red


$ChocolateyProfile = "$env:ChocolateyInstall\helpers\chocolateyProfile.psm1"
if (Test-Path($ChocolateyProfile)) {
    Import-Module "$ChocolateyProfile"
}

#Functions
function which ($command) {
  Get-Command -Name $command -ErrorAction SilentlyContinue |
  Select-Object -ExpandProperty Path -ErrorAction SilentlyContinue
}

$env:modules = "C:\Users\MALDEV01\Documents\WindowsPowerShell\Modules"
$env:profile = "C:\Users\MALDEV01\Documents\WindowsPowerShell\"

