[xml]$XAML = @"
<Window x:Class="WpfWatermark.MainWindow"
        xmlns="http://schemas.microsoft.com/winfx/2006/xaml/presentation"
        xmlns:x="http://schemas.microsoft.com/winfx/2006/xaml"
        xmlns:d="http://schemas.microsoft.com/expression/blend/2008"
        xmlns:mc="http://schemas.openxmlformats.org/markup-compatibility/2006"
        xmlns:local="clr-namespace:WpfWatermark"
        mc:Ignorable="d"
        Title="PDF2JPEG" Height="244.298" Width="528.106">
    <Grid Margin="0,0,-8,50">
        <Grid.ColumnDefinitions>
            <ColumnDefinition Width="47*"/>
            <ColumnDefinition Width="18*"/>
            <ColumnDefinition Width="199*"/>
        </Grid.ColumnDefinitions>
        <TextBox x:Name="txtBoxOpen" HorizontalAlignment="Left" Height="20" Margin="10,73,0,0" TextWrapping="Wrap" VerticalAlignment="Top" Width="400" Grid.ColumnSpan="3"/>
        <TextBox x:Name="txtBoxSave" HorizontalAlignment="Left" Height="20" Margin="10,125,0,0" TextWrapping="Wrap" VerticalAlignment="Top" Width="400" Grid.ColumnSpan="3"/>
        <Button x:Name="btnOpen" Content="Öffnen" HorizontalAlignment="Left" Margin="296,73,0,0" VerticalAlignment="Top" Width="75" Grid.Column="2"/>
        <Button x:Name="btnSave" Content="Speichern" HorizontalAlignment="Left" Margin="296,125,0,0" VerticalAlignment="Top" Width="75" Grid.Column="2"/>
        <ComboBox x:Name="comboBox" HorizontalAlignment="Left" Margin="251,25,0,0" VerticalAlignment="Top" Width="120" RenderTransformOrigin="0.146,0.526" SelectedIndex="0" Grid.Column="2">
            <ComboBoxItem>300</ComboBoxItem>
            <ComboBoxItem>600</ComboBoxItem>
        </ComboBox>
        <Label x:Name="lblOpen" Content="PDF-Datei öffnen..." HorizontalAlignment="Left" Height="26" Margin="10,47,0,0" VerticalAlignment="Top" Width="400" Grid.ColumnSpan="3"/>
        <Label x:Name="lblSave" Content="JPEG-Datei speichern..." HorizontalAlignment="Left" Height="25" Margin="10,100,0,0" VerticalAlignment="Top" Width="400" Grid.ColumnSpan="3"/>
        <Label x:Name="lblWatermark" Content="Druckauflösung:" HorizontalAlignment="Left" Margin="150,23,0,0" VerticalAlignment="Top" RenderTransformOrigin="0.14,-0.114" Width="159" Grid.Column="2"/>
    </Grid>
</Window>
"@ -replace 'mc:Ignorable="d"','' -replace "x:N",'N' -replace '^<Win.*', '<Window' #-replace wird benötigt, wenn XAML aus Visual Studio kopiert wird.

#XAML laden
[void][Reflection.Assembly]::LoadWithPartialName('presentationframework')
try{
  $Form = [Windows.Markup.XamlReader]::Load( (New-Object System.Xml.XmlNodeReader $XAML) )
} catch {
  Write-Host "Windows.Markup.XamlReader konnte nicht geladen werden. Mögliche Ursache: ungültige Syntax oder fehlendes .net"
}
$xaml.SelectNodes("//*[@Name]") | ForEach-Object {Set-Variable -Name ($_.Name) -Value $Form.FindName($_.Name)}

function Open-FileDialog
{
  Add-Type -AssemblyName System.Windows.Forms
  $file = New-Object System.Windows.Forms.OpenFileDialog #SaveFileDialog
  $file.Filter = "PDF files (*.pdf)|*.pdf"
  $file.FilterIndex = 2
  $file.RestoreDirectory = $true
  $show = $file.ShowDialog()
	
  if ($show -eq [System.Windows.Forms.DialogResult]::OK)
  {
    $file.FileName		
  }
}

function ConvertTo-JPEG
{
  param
  (
    [String]
    [Parameter(Mandatory)]
    $Resolution,
    
    [String]
    [Parameter(Mandatory)]
    $OutputFile,
    
    [String]
    [Parameter(Mandatory)]
    $InputFile
  )
  
  $Batch = '-dBATCH'
  $Pause = '-dNOPAUSE'
  $Out   = '-sOutputFile={0}' -f $OutputFile
  $Compression = '-sDEVICE=jpeg'
  $cr = '-r{0}' -f $Resolution

  $executeable = "$env:ProgramFiles\gs\gs*\bin\gswin64c.exe"
  $parameters  = ('{0} {1} {2} {3} "{4}" "{5}"' -f $Compression, $cr, $Batch, $Pause, $Out, $InputFile)
  
  if (Test-Path $executeable) 
  {
    Write-Verbose "$executeable $parameters"
    Start-Process -FilePath $executeable -ArgumentList $parameters -Wait
  }
  else
  {
    $ws = New-Object -ComObject wscript.shell
    $result = $ws.Popup("GhostView ist nicht installiert!",0,"PDF2JPEG",0)
  }
}

function Save-FileDialog
{ 
  ConvertTo-JPEG -Resolution $global:dpi -OutputFile $savefilename -InputFile $filename
}

$btnOpenMethod = $btnOpen.add_click 
$btnOpenMethod.Invoke({

    $global:filename = Open-FileDialog
    $txtBoxOpen.Text = $filename    
    $newfilename = $filename -replace ('.pdf', '.jpg')    
    $txtBoxSave.Text = $newfilename
    
})

$btnSaveMethod = $btnSave.add_Click
$btnSaveMethod.Invoke({

    if ($comboBox.Text -eq '300')
    {
      $global:dpi = '300'
    }
    elseif ($comboBox.Text -eq '600')
    {
      $global:dpi = '600'   
    }

    $savefilename = $txtBoxSave.Text
    Save-FileDialog
    $ws = New-Object -ComObject wscript.shell
    $result = $ws.Popup("JPG-Datei im Verzeichnis`n`"$savefilename`" erstellt.",0,"PDF2JPEG",0)
})

#Fenster anzeigen:
$null = $Form.ShowDialog()
