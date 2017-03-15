<#
.Synopsis
   Use-RadioPlayer -- A small radio player for the PowerShell

.DESCRIPTION
   Adapt this script to listen to your favorit radio stations 
   in a PowerShell terminal

.EXAMPLE
   Simply run this script an get a simple menu:

   RadioPlayer - Listen to your stream!
   ====================================

   (B)BC 6 || (F)M 4.ORF || (K)oeln Campus: f

   (P)lay || (S)top || (Q)uit: p

.NOTES
      Christian Imhorst 
      @datenteiler 
      http://www.datenteiler.de 
      
.LINK
      http://github.com/datenteiler
#>

Clear-Host

"RadioPlayer - Listen to your stream!"
"===================================="
Add-Type -AssemblyName PresentationCore
$mediaPlayer = New-Object -TypeName system.windows.media.mediaplayer
 
$s = Read-Host -Prompt "`n(B)BC 6 || (F)M 4.ORF || (K)oeln Campus"
if ($s -eq 'F'){$stream = 'mms://apasf.apa.at/fm4_live_worldwide'}
elseif ($s -eq 'B'){$stream = 'http://bbcmedia.ic.llnwd.net/stream/bbcmedia_6music_mf_p'}
elseif ($s -eq 'K'){$stream = 'http://koelncampus.uni-koeln.de/hq.m3u'}
else {"`nBad Entry";break}
 
$mediaPlayer.open([uri]('{0}' -f ($stream)))
 
while(($c = Read-Host -Prompt "`n(P)lay || (S)top || (Q)uit") -ne 'Q')
{
  switch($c)
  {
    P {('Playing {0}' -f $stream)
        $mediaPlayer.Play()}
    S {'Stop'
        $mediaPlayer.Stop()}
    Q {'Quit'}
    default {"`nBad Entry"}
  }
}
$mediaPlayer.Stop()
"Quit"
