function Get-FM4Tracks
{
  <#
      .Synopsis
      Get-FM4Tracks shows what's currently playing on FM4

      .DESCRIPTION
      FM4 is an Austrian national radio station, operated by the ORF. 
      Its main target is the youth audience, and much of the music 
      output is characterised by an alternative rock and electronic 
      music slant.

      .EXAMPLE
      Get-FM4Tracks
  #>
    $web = New-Object Net.WebClient
    $web.UseDefaultCredentials = $true
    $web.Proxy.Credentials = $web.Credentials
    $url = "http://fm4.orf.at/trackservicepopup/"
    $str = $web.DownloadString($url)
    sleep 1
    $result = ([regex]'\d{0,2}:\d{0,2}:.*').matches($str) | foreach {$_.Groups[0].Value}
    $result -replace "<.*?>" 
}
