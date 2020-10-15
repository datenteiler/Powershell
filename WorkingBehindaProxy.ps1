$webclient = New-Object System.Net.WebClient
$creds = Get-Credential
$webclient.Proxy.Credentials = $creds
$(Invoke-WebRequest -Uri 'http://wttr.in/Hannover,Germany').ParsedHtml.body.outerText
