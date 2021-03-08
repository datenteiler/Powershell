function Get-DangerousAssoc
{
  <#
    .SYNOPSIS
    Get-DangerousAssoc can show if a file extension is dangerous or not

    .DESCRIPTION
    If you want to know if a file extension is dangerous in Windows you can 
    check the extension with Get-DangerousAssoc.

    .EXAMPLE
    Get-DangerousAssoc -extension txt
    Check if a file extension like txt or exe is dangerous
  #>

  [CmdletBinding()]
  param(
    [Parameter(Mandatory=$true,HelpMessage='The extension you want to check like exe or txt',
        ValueFromPipeline=$true,
    Position=0)]
    [string]$extension 
  ) 
  $signature = @' 
  [DllImport("shlwapi.dll", CharSet=CharSet.Unicode )] 
  public static extern bool AssocIsDangerous( 
      string extension); 
'@ 
  $type = Add-Type -MemberDefinition $signature -Name Win32Utils -PassThru
  Write-Verbose -Message ('Checking file extension {0}' -f $extension) 
  $type::AssocIsDangerous(('.{0}' -f $extension))
} 
