# Import-Module .\LDAPFind.ps1
# LDAPSearch -LDAPQuery "(samAccountType=805306368)"

function LDAPFind {
    param (
        [string]$LDAPQuery
    )
    $PDC = [System.DirectoryServices.ActiveDirectory.Domain]::GetCurrentDomain().PdcRoleOwner.Name
    $DN = ([adsi]'').distinguishedName
    $LDAP = "LDAP://$PDC/$DN"
    
    $direntry = New-Object System.DirectoryServices.DirectoryEntry($LDAP)
    $dirsearcher = New-Object System.DirectoryServices.DirectorySearcher($direntry)
    $dirsearcher.Filter = $LDAPQuery
    return $dirsearcher.FindAll()
}
