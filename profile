Set-ExecutionPolicy -ExecutionPolicy unrestricted 
Set-MpPreference -DisableIOAVProtection $true
Set-MpPreference -DisableRealtimeMonitoring $true 
$WarningPreference = 'SilentlyContinue'
Import-Module C:\Users\kermit\Documents\WindowsPowerShell\Modules\nishang\nishang.psm1

$nombreVariable = "modules"
$rutaDirectorio = "C:\Users\kermit\Documents\WindowsPowerShell\Modules\"

# Verificar si la variable de entorno ya existe
if (-not (Test-Path "env:$nombreVariable")) {
    # Crear la variable de entorno si no existe
    [System.Environment]::SetEnvironmentVariable($nombreVariable, $rutaDirectorio, [System.EnvironmentVariableTarget]::User)
}

# Guardar el valor actual de PATH
$originalPath = [System.Environment]::GetEnvironmentVariable("PATH", [System.EnvironmentVariableTarget]::User)

# Agregar tus nuevas rutas al PATH
$Variable_Name = "C:\cmd\"
[Environment]::SetEnvironmentVariable("PATH", "$originalPath;$Variable_Name", [System.EnvironmentVariableTarget]::User)

# Restaurar las rutas originales si lo deseas
# [Environment]::SetEnvironmentVariable("PATH", $originalPath, [System.EnvironmentVariableTarget]::User)

Write-Host "`t Go modules:" -NoNewline
Write-Host "`t cd `$env:modules `n" -ForegroundColor Red

$ChocolateyProfile = "$env:ChocolateyInstall\helpers\chocolateyProfile.psm1"
if (Test-Path($ChocolateyProfile)) {
    Import-Module "$ChocolateyProfile"
}
