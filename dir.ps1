<#
  .SYNOPSIS
  Use the good old dir command in PowerShell

  .DESCRIPTION
  Remove the dir alias to get child-item and 
  take the old dir command instead

  .EXAMPLE
  dir /r
  Display alternate data streams

  .NOTES
  Christian Imhorst 
  @datenteiler 
  http://www.datenteiler.de
#>

If (Test-Path Alias:dir) {Remove-Item Alias:dir}
function dir
{
    Param
    (
        [Parameter(Mandatory=$true, Position=0)]
        [string]$Param='/a'
    )
    $scriptblock = {cmd /c dir $Param}
    Invoke-Command -Scriptblock $scriptblock
}
