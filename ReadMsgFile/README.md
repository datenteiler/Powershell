PowerShell binary Cmdlet Read-MsgFile and Get-MsgAttachment
===========================================================

Read-MsgFile and Get-MsgAttachment reads emails saved in Microsoft Outlook's .msg files and extracts attachments from a .msg file.


How to Compile and start:
-------------------------

```dotnet restore
dotnet publish -c Release
ipmo ~/ReadMsgFiles/ReadMsgFile/bin/Release/netstandard2.0/publish/ReadMsgFile.dll
Read-MsgFile -File /home/christian/sample.msg | Select-Object Subject 
```


