# Define una función para procesar los objetos de AD (usuarios y computadoras)
function Process-ADObjectWithRBCD {
    param(
        [Parameter(Mandatory = $true)]
        $ADObject
    )
    Write-Output "Processing object: $($ADObject.name)"
    $binaryValue = $ADObject.'msDS-AllowedToActOnBehalfOfOtherIdentity'
    
    # Convierte el valor binario a un descriptor de seguridad
    $sd = New-Object Security.AccessControl.RawSecurityDescriptor -ArgumentList $binaryValue, 0

    # Muestra información del descriptor de seguridad
    $sd.DiscretionaryAcl | ForEach-Object {
        $sid = $_.SecurityIdentifier.ToString()
        # Intenta convertir el SID a un nombre de objeto usando ConvertFrom-SID
        try {
            $objectName = ConvertFrom-SID $sid
            Write-Output "SID: $sid has object name: $objectName"
        } catch {
            Write-Output "SID: $sid could not be converted to an object name."
        }
        Write-Output "Access Mask: $($_.AccessMask)"
        Write-Output "Ace Type: $($_.AceType)"
        Write-Output "---------------------------"
    }
    Write-Output "======================================="
}

# Obtiene y procesa todas las computadoras del dominio con RBCD configurado
$computersWithRBCD = Get-DomainComputer | Where-Object {$_.'msDS-AllowedToActOnBehalfOfOtherIdentity' -ne $null}
foreach ($computer in $computersWithRBCD) {
    Process-ADObjectWithRBCD -ADObject $computer
}

# Obtiene y procesa todos los usuarios del dominio con RBCD configurado
$usersWithRBCD = Get-DomainUser | Where-Object {$_.'msDS-AllowedToActOnBehalfOfOtherIdentity' -ne $null}
foreach ($user in $usersWithRBCD) {
    Process-ADObjectWithRBCD -ADObject $user
}
