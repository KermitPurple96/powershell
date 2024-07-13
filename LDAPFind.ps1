# LDAPFind -LDAPQuery "(objectCategory=group)"
# LDAPSearch -LDAPQuery "(samAccountType=805306368)"
# LDAPFind -LDAPQuery "(&(objectCategory=group)(cn=Remote Management Users))"

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
    
    $searchResults = $dirsearcher.FindAll()
    
    foreach ($group in $searchResults) {
        $group.Properties | Select-Object @{Name="Group Name"; Expression={$_.cn}}, @{Name="Members"; Expression={$_.member}}
    }
}
