#!/usr/bin/env powershell
#requires -version 5.0

function Get-PowerShell6ReleaseArtifactFileHash
{
    <#
      .Synopsis
       Get SHA256 Hashes of the PowerShell 6 release artifacts
      .DESCRIPTION
       Get the SHA256 Hashes of the PowerShell 6 release artifacts
       from PowerShell's GitHub release page.
      .EXAMPLE
       Get-PowerShell6ReleaseArtifactFileHash

       Get all PowerShell 6 SHA256 Hashes from GitHub 
      .EXAMPLE
       Get-PowerShell6ReleaseArtifactFileHash -Filename PowerShell_6.0.0-alpha.15-win7-x86.zip

       Gets SHA256 Hash for a PowerShell 6 release artifact
       .LINK
       https://github.com/PowerShell/PowerShell/releases/
    #>
    Param
    (
        # Filename of the release artifact
        [Parameter(ValueFromPipeline,
                   Position=0)]
        [string]$Filename = $null
    )

    Begin
    {
      # Home of PowerShell 6
      $uri = 'https://api.github.com/repos/PowerShell/PowerShell/releases'
      
      # Check if website is available
      Try
      {
        $null = Invoke-WebRequest -Uri $uri | ForEach-Object {$_.StatusCode}
      }
      Catch
      {
        $_.Exception.Message
        Break
      }
    }
    Process
    {
      $data = (((Invoke-WebRequest -Uri $uri).AllElements[0].Innertext | ConvertFrom-Json)[0].Body)
      $string = [regex]::Matches("$data", '[Pp]ower[\w-.]+[-_].*\n.*').value | 
          ConvertFrom-String -Delimiter '- ' -PropertyNames Filename, Hash
    }
    End
    {
      if ($Filename)
      {
        foreach ($s in $string)
        {
         if ($filename.trim() -eq ($s.filename).tostring().trim())
          {
            ($s.Hash).tostring().trim()
          }
        }
      }
      else  
      {
        $string
      }
    }
}
