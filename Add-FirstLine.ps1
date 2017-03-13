filter Add-FirstLine ([string]$Path){
  <#
    .SYNOPSIS
    Add-FirstLine - Add a first line to a text file.

    .DESCRIPTION
    Add a first line to a text file.

    .PARAMETER Path
    Set path to the text file.

    .EXAMPLE
    'String' | Add-FirstLine -Path Value
    Puts value of 'String' into the first line of the
    file in path
  #>

  $contents = Get-Content -Path $Path
  $_ | Set-Content -Path $Path
  $contents | Add-Content -Path $Path
} 
