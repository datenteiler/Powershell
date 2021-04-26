function Show-Console
{
  <#
    .SYNOPSIS
    With Show-Console you can hide and show Console Windows again.

    .DESCRIPTION
    You can show and hide your Console Window

    .PARAMETER Show
    Show your Console Window with -Show.

    .PARAMETER Hide
    Hide your Console Window with -Hide.

    .EXAMPLE
    Show-Console -Hide
    This call hides your Console Window

    .NOTE
    The original of this function is at StackOverflow:
    https://stackoverflow.com/questions/40617800/opening-powershell-script-and-hide-command-prompt-but-not-the-gui
  #>


    [CmdletBinding()]
    param ([Switch]$Show,[Switch]$Hide)
    if (-not ('Console.Window' -as [type])) { 

        Add-Type -Name Window -Namespace Console -MemberDefinition '
        [DllImport("Kernel32.dll")]
        public static extern IntPtr GetConsoleWindow();

        [DllImport("user32.dll")]
        public static extern bool ShowWindow(IntPtr hWnd, Int32 nCmdShow);
        '
    }

    if ($Show)
    {
        $consolePtr = [Console.Window]::GetConsoleWindow()

        # Hide = 0,
        # ShowNormal = 1,
        # ShowMinimized = 2,
        # ShowMaximized = 3,
        # Maximize = 3,
        # ShowNormalNoActivate = 4,
        # Show = 5,
        # Minimize = 6,
        # ShowMinNoActivate = 7,
        # ShowNoActivate = 8,
        # Restore = 9,
        # ShowDefault = 10,
        # ForceMinimized = 11

        $null = [Console.Window]::ShowWindow($consolePtr, 5)
    }

    if ($Hide)
    {
        $consolePtr = [Console.Window]::GetConsoleWindow()
        #0 hide
        $null = [Console.Window]::ShowWindow($consolePtr, 0)
    }
}

