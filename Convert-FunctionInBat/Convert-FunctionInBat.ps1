# This is Powershell function will be coded with Base64:
$code = {
Clear-Host
function Get-Message
{
Param
(
    $message = "Hallo Welt!"
)

    [void][reflection.assembly]::LoadWithPartialName("System.Windows.Forms")
    $null = [windows.forms.messagebox]::Show("$message","Die Nachricht", `
    [Windows.Forms.MessageBoxButtons]::OK ,[Windows.Forms.MessageBoxIcon]::Information)
}

Get-Message
}

# Code the function to Base64
$coding = [convert]::ToBase64String([Text.Encoding]::Unicode.GetBytes($code))

# Create a Batch file to execute the coded Base64 code with PowerShell:
$batch = "C:\Users\Public\Message.bat"
if (Test-Path $batch) { Remove-Item $batch }

$batchfile = @"
@ECHO OFF
CLS
POWERSHELL -EncodedCommand $coding
ECHO.
CLS
EXIT /B
"@

$batchfile | Out-File -FilePath $batch -Encoding ASCII

# Decode Base64:
# [System.Text.Encoding]::Unicode.GetString([System.Convert]::FromBase64String($($($((Get-Content "C:\Users\Public\Message.bat")[2]).Split(" "))[2]))) 
