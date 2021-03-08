function Get-Beep
{
  <#
      .SYNOPSIS
      Get-Beep gives you a beep

      .DESCRIPTION
      If you want to hear a sound, you can do this with Get-Beep.
      There is an easier way to hear a beep in PowerShell when you
      use the .NET class Console which represents the standard input, 
      output, and error streams for console applications:

      [console]::Beep(550, 500)

      But in the background the .NET class is using the Windows library 
      kernel32.dll for that.

      .EXAMPLE
      Get-Beep -freq 550 -dur 500
      Play a beep with frequency 550 and duration of 500

  #>

    [CmdletBinding()]
    param(
    [Parameter(Mandatory=$true,HelpMessage='Type your frequency as number',
        ValueFromPipeline=$true,
    Position=0)]
    [uint32]$Frequency,
    
    [Parameter(Mandatory=$true,HelpMessage='Type your duration as number',
        ValueFromPipeline=$true,
    Position=1)]    
    [uint32]$Duration 
  ) 

    $signature = @' 
    [DllImport("kernel32.dll")] 
    public static extern bool Beep( 
      uint dwFreq, 
      uint dwDuration); 
'@ 

    $type = Add-Type -MemberDefinition $signature -Name Win32Utils -PassThru 
    $null = $type::Beep($Frequency, $Duration) 
} 
