Stop-Process -Name OUTLOOK -Force -ErrorAction SilentlyContinue
$ws = New-Object -ComObject wscript.shell
$result = $ws.Popup("Shall I reset your Outlook profile?",0,"Reset Outlook Profil",4)
if ($result -eq "6")
{
  Remove-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Office\16.0\Outlook\" -Name DefaultProfile -ErrorAction SilentlyContinue
  Remove-Item -Path "HKCU:\SOFTWARE\Microsoft\Office\16.0\Outlook\Profiles\*" -Recurse -ErrorAction SilentlyContinue
  Remove-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Office\16.0\Outlook\Setup\" -Name First-Run -ErrorAction SilentlyContinue
  if (!(Test-Path "HKCU:\SOFTWARE\Microsoft\Office\AutoDiscover\"))
  {
      New-Item "HKCU:\SOFTWARE\Microsoft\Office\AutoDiscover\"
  }
  New-ItemProperty -PropertyType DWord -Path "HKCU:\SOFTWARE\Microsoft\Office\AutoDiscover\" -Name ZeroConfigExchange -Value 1 -ErrorAction SilentlyContinue
  $result = $ws.Popup("Done!",0,"Reset Outlook Profil",1)
}
