<#
    .Synopsis
    Set creation date, last access and last write time of a file
    .DESCRIPTION
    If you want to artificially age a file, this script is for you.
    .EXAMPLE
    Reset-TimeOfFile -filename .\test.txt -SetCreationTime "01.05.2013" -Verbose
    .EXAMPLE
    Reset-TimeOfFile -filename .\test.txt -SetCreationTime "05.05.2013" -SetLastAccessTime "05.05.2013" -SetLastWriteTime "05.05.2013"

#>
function Reset-TimeOfFile
{
    [CmdletBinding()]
    Param
    (
        # Param1 help description
        [Parameter(Mandatory=$true,
                   ValueFromPipelineByPropertyName=$true,
                   Position=0)]
        $filename,

        # Param2 help description
        # Param1 help description
        [Parameter(Mandatory=$true,
                   Position=1)]
        [string]$SetCreationTime,
        
        [string]$SetLastAccessTime,
        
        [string]$SetLastWriteTime
    )

    $SCT = Get-Date $SetCreationTime
    Write-Verbose "Set last access time to $SCT"
    [System.IO.File]::SetCreationTime($filename, $SCT)
  
  
    if ($SetLastAccessTime)
    {
      $SLAT = Get-Date $SetLastAccessTime
      Write-Verbose "Set last access time to $SLAT"
      [System.IO.File]::SetLastAccessTime($filename, $SLAT)
    }
    
    if ($SetLastWriteTime)
    {
      $SLWT = Get-Date $SetLastWriteTime
      Write-Verbose "Set last write time to $SLWT"
      [System.IO.File]::SetLastWriteTime($filename, $SLWT)
    }
}
