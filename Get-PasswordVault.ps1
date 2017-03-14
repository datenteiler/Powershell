function Get-PasswordVault
{
  <#
    .SYNOPSIS
    Get-PasswordVault shows credentials of Credential Locker.

    .DESCRIPTION
    The PasswordVault class represents a Credential Locker of credentials. 

    .EXAMPLE
    Get-PasswordVault
    Shows all credentials in a Credential Locker.

    .NOTES
    Christian Imhorst
    @datenteiler

    .LINK
    https://docs.microsoft.com/en-us/uwp/api/windows.security.credentials.passwordvault
  #>

  $null = [Windows.Security.Credentials.PasswordVault,Windows.Security.Credentials,ContentType=WindowsRuntime]
  $items = (New-Object -TypeName Windows.Security.Credentials.PasswordVault).RetrieveAll()
  ForEach ($i in $items) 
  { 
    $i.RetrievePassword() 
    $i 
  }
}
