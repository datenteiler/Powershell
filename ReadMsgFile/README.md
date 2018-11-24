PowerShell binary cmdlet Read-MsgFile and Get-MsgAttachment
===========================================================

Read-MsgFile and Get-MsgAttachment reads emails saved in Microsoft Outlook's .msg files and extracts attachments from them.


How to compile and start:
-------------------------

```
dotnet restore
dotnet publish -c Release
ipmo bin/Release/netstandard2.0/publish/ReadMsgFile.dll
Read-MsgFile -File sample.msg 
```

The cmdlet will show the content of the .msg file like sender and receiver, the email body etc. The output are objects, not only text.

The cmdlet is using MSGReader by @Sicos1977 and 
