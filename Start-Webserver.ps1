function Start-Webserver
{
  <#
      .SYNOPSIS
      Starts or stops the Apache webserver from WSL bash.exe.

      .DESCRIPTION
      First you have to install Apache in bash.exe:
    
      1. Enable WSL
      2. Run installation: lxrun /install
      3. Open bash.exe and install LAMP or Apache as root
      4. apt install lamp-server^ (or: apt install apache)
      5. Add this line to the end of /etc/apache2/apache2.conf:
          
      AcceptFilter http none

      6. Test if it work:

      /etc/init.d/apache2 start
      
      .PARAMETER Start
      Starts Apache webserver from bash.exe.

      .PARAMETER Restart
      Restarts Apache webserver from bash.exe.

      .PARAMETER Stop
      Stops Apache webserver from bash.exe.

      .EXAMPLE
      Start-Webserver -Start 
      Start Apache webserver.

      .EXAMPLE
      Stop-Webserver -Stop 
      Stop Apache webserver.

      .NOTES
      Christian Imhorst
      https://twitter.com/datenteiler
      datenteiler.de
  #>

  [CmdletBinding()]
  param
  (
    [switch]
    $Start,
    [switch]
    $Restart,
    [switch]
    $Stop
  )
  if ($Start -and !$Restart -and !$Stop){[string]$state = 'start'}
  elseif ($Restart -and !$Start -and !$Stop){[string]$state = 'restart'}
  elseif ($Stop -and !$Restart -and !$Start){[string]$state = 'stop'}
  else {
    Write-Output -InputObject ('Usage: {0} -[Start|Stop|Restart]' -f $MyInvocation.MyCommand.Name)
    break
  } 
  
  # Path to bash.exe
  $bash = "$env:windir\system32\bash.exe"
  
  # Open hidden bash.exe to keep the webserver running:
  if ((Get-Process).Name -notcontains 'bash')
  { 
    Start-Process -WindowStyle hidden -FilePath $bash
  }
  # (Re)start or stop webserver:
  $cmd = & $bash @('-c', ('/etc/init.d/apache2 {0}' -f $state))
  Write-Output -InputObject ('{0}' -f $cmd[0])
  Write-Output -InputObject (' * http://{0}' -f $(& "$env:windir\system32\hostname.exe"))
}
