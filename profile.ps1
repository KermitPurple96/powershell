Set-ExecutionPolicy -ExecutionPolicy unrestricted 
Set-MpPreference -DisableIOAVProtection $true
Set-MpPreference -DisableRealtimeMonitoring $true 
$WarningPreference = 'SilentlyContinue'


New-Alias -Name np -Value "C:\cmd\Notepad++.lnk" -Force



Import-Module C:\Users\kermit\Documents\WindowsPowerShell\Modules\nishang\nishang.psm1

$nombreVariable = "modules"
$rutaDirectorio = "C:\Users\kermit\Documents\WindowsPowerShell\Modules\"


$modulesPath = "C:\Users\kermit\Documents\WindowsPowerShell\Modules\"
$empirePath = "C:\Users\kermit\Documents\WindowsPowerShell\Modules\Empire\data\module_source\"

# Obtener todos los archivos .psm1 y .ps1 recursivamente desde los directorios
$null = Get-ChildItem -Path $modulesPath, $empirePath -Recurse -Filter *.ps1

# Importar cada módulo
foreach ($moduleFile in $moduleFiles) {
    Import-Module $moduleFile.FullName
}

# Guardar el valor actual de PATH
$originalPath = [System.Environment]::GetEnvironmentVariable("PATH", [System.EnvironmentVariableTarget]::User)

# Agregar tus nuevas rutas al PATH
$Variable_Name = "C:\cmd\"
[Environment]::SetEnvironmentVariable("PATH", "$originalPath;$Variable_Name", [System.EnvironmentVariableTarget]::User)

#####################
$originalPath = [System.Environment]::GetEnvironmentVariable("PATH", [System.EnvironmentVariableTarget]::User)
$Variable_Name = "C:\Users\kermit\Documents\WindowsPowerShell\Modules"
[Environment]::SetEnvironmentVariable("PATH", "$originalPath;$Variable_Name", [System.EnvironmentVariableTarget]::User)
#####################

#####################
$originalPath = [System.Environment]::GetEnvironmentVariable("PATH", [System.EnvironmentVariableTarget]::User)
$Variable_Name = "C:\cmd\Ghostpack-CompiledBinaries"
[Environment]::SetEnvironmentVariable("PATH", "$originalPath;$Variable_Name", [System.EnvironmentVariableTarget]::User)
#####################

# Restaurar las rutas originales si lo deseas
# [Environment]::SetEnvironmentVariable("PATH", $originalPath, [System.EnvironmentVariableTarget]::User)

Write-Host "`t Go modules:" -NoNewline
Write-Host "`t cd `$env:modules `n" -ForegroundColor Red

$ChocolateyProfile = "$env:ChocolateyInstall\helpers\chocolateyProfile.psm1"
if (Test-Path($ChocolateyProfile)) {
    Import-Module "$ChocolateyProfile"
}
