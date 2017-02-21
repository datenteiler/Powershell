#requires -version 5.0

function Get-PowerShellHashesFromGitHub
{
  <#
      .Synopsis
      Get SHA256 Hashes of the PowerShell 6 release artifacts
      .DESCRIPTION
      Get the SHA256 Hashes of the PowerShell 6 release artifacts
      from PowerShell's GitHub release page.
      .EXAMPLE
      Get-PowerShell6ReleaseArtifactFileHash | Format-Table -AutoSize -Wrap

      Show all PowerShell 6 SHA256 Hashes from GitHub 
      .EXAMPLE
      Get-PowerShell6ReleaseArtifactFileHash -Filename PowerShell_6.0.0-alpha.15-win7-x86.zip

      Show SHA256 Hash for a PowerShell 6 release artifact
      .NOTES
      Christian Imhorst
      @datenteiler
      http://www.datenteiler.de
      github.com/datenteiler

      .VERSION HISTORY
        1.0.0.0 | Christian Imhorst
          Initial version 
        1.0.0.1 | Christian Imhorst
          Exchanged ConvertFrom-String with ConvertFrom-StringData,
          because PowerShell 6 didn't support ConvertFrom-String
        1.0.0.2 | Christian Imhorst          
          Optimized RegEx 
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
    $string = [regex]::Matches("$data", '(?i)power[\w-.]+[-_].*\n.*').value
    $hash = @{}
    ForEach ($s in $string){
      $hash += ConvertFrom-StringData -StringData ($s -replace '\n.- ', '=')
    }   
  }
  End
  {
    if ($Filename)
    {
      $hash.GetEnumerator() | ForEach-Object {
        if ($Filename -eq $_.name)  {$_.value}
      }
    }
    else  
    {
      $hash
      }
    }
}
