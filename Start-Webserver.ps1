function Start-Webserver
{
  <#
      .SYNOPSIS
      Starts or stops the Apache webserver from WSL bash.exe.

      .DESCRIPTION
      You have to install Apache in bash.exe before:
    
      i. Enable WSL
      ii. Run installation: lxrun /install
      iii. Open bash.exe and install LAMP or Apache as root
      iv. apt install lamp-server^ (or alt.: apt install apache)
      v. Add this line to the end of /etc/apache2/apache2.conf:
          
      AcceptFilter http none

      vi. Test if it work:

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
      Stop-Webserver -Start 
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
  if ($Start){[string]$state = 'start'}
  elseif ($Restart){[string]$state = 'restart'}
  elseif ($Stop){[string]$state = 'stop'}
  else {
    Write-Output "Usage: $($MyInvocation.MyCommand.Name) -[Start|Stop|Restart]"
    break
  } 
  # (Re)start or stop webserver
  $cmd = & "$env:windir\system32\bash.exe" @('-c', ('/etc/init.d/apache2 {0}' -f $state))
  Write-Output ('{0}' -f $cmd[0])
  Write-Output (' * http://{0}' -f $(hostname))
}
