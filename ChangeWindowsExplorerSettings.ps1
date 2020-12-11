function Change-WindowsExplorerSettings
{
    "Datei Explorer öffnen für: 'Dieser PC' und Erweiterungen bei bekannten Datentypen 'nicht' ausblenden ..."
    $key = "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced"
    Set-ItemProperty $key LaunchTo 1
    Set-ItemProperty $key HideFileExt 0 
    Set-ItemProperty $key Hidden 2 

    "Datenschutzhaken entfernen ..."
    $pkey = "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer"
    Set-ItemProperty $pkey ShowFrequent 0
    Set-ItemProperty $pkey ShowRecent 0 

    "Explorer neu starten ..."
    Stop-Process -processname explorer
}
