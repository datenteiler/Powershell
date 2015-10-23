function Get-FM4Tracks {
    $web = New-Object Net.WebClient
    $web.UseDefaultCredentials = $true
    $web.Proxy.Credentials = $web.Credentials
    $url = "http://fm4.orf.at/trackservicepopup/"
    $str = $web.DownloadString($url)
    sleep 5
    $result = ([regex]‘\d{0,2}:\d{0,2}:.*’).matches($str) | foreach {$_.Groups[0].Value}
    $result -replace "<.*?>" 
}

Get-FM4Tracks
