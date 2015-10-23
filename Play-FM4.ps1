$WMP = new-object -com WMPLAYER.OCX
$aURL = 'mms://apasf.apa.at/fm4_live_worldwide'
$wmp.openplayer($aURL)
