Enum ShowStates
{
   Hide = 0
   Normal = 1
   Minimized = 2
   Maximized = 3
   ShowNoActivateRecentPosition = 4
   Show = 5
   MinimizeActivateNext = 6
   MinimizeNoActivate = 7
   ShowNoActivate = 8
   Restore = 9
   ShowDefault = 10
   ForceMinimize = 11
}

function Set-Console
{
  <#
      .SYNOPSIS
      Mit Set-Console kann man das Fenster seiner PowerShell-Konsole verstecken,
      minimieren, maximieren uvm.

      .DESCRIPTION
      Das Fenster der PowerShell-Konsole kann verschiedene Zustände annehmen wie
      groß, klein, versteckt uvm.

      .EXAMPLE
      Set-Console -Window Hide
      Das Konsolenfenster verschwindet wie durch Zauberhand

  #>
  
    [CmdletBinding()]
    param 
    (
      [ShowStates]$Window = [ShowStates]::Normal
    )
    
    begin
    {
      $signature = @'
      [DllImport("Kernel32.dll")]
      public static extern IntPtr GetConsoleWindow();
      [DllImport("user32.dll")]
      public static extern bool ShowWindow(IntPtr hWnd, Int32 nCmdShow);
'@
      if (-not ('Console.Window' -as [type])) {
          Add-Type -Name Window -Namespace Console -MemberDefinition $signature -PassThru
      }
    }
    
    process
    {
      $consolePtr = [Console.Window]::GetConsoleWindow()
      $null = [Console.Window]::ShowWindow($consolePtr, $Window)
    }
}
