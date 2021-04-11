## Eine DLL als Beispiel für Add-Type in PowerShell

Benötigt wird dafür Visual Studio, wobei die Community Edition reicht. Es reicht allerdings aus, die Kommandozeilen-Tools zum Kompilieren zu verwenden

Zuerst werden die Umgebungsvariablen gesetzt, bevor man mit dem Kompilieren beginnen kann:

```
"C:\Program Files (x86)\Microsoft Visual Studio\2019\Community\VC\Auxiliary\Build\vcvarsx86_amd64.bat"
```

Die Dateien ```addiere.c``` und ```addiere.h``` müssem im selben Ordner liegen:

```
"C:\Program Files (x86)\Microsoft Visual Studio\2019\Community\VC\Tools\MSVC\14.28.29910\bin\Hostx64\x64\cl.exe" /c addiere.c
"C:\Program Files (x86)\Microsoft Visual Studio\2019\Community\VC\Tools\MSVC\14.28.29910\bin\Hostx64\x64\link.exe" /DLL /out:addiere.dll addiere.obj
```

Anschließend kann die DLL mit ```Add-Type``` in die PowerShell importiert und ausgeführt werden:

```
$signature = @'
[DllImport("addiere.dll")]
public static extern int addiere(
          int augend,
          int addend
          );
'@ 

$type = Add-Type -MemberDefinition $signature -Name Addiere -Namespace Win32 -PassThru
$type::addiere(3,2)
[Win32.Addiere]::addiere(2,5)
```

Sollte statt einem Ergebnis die Fehlermeldung ```"Es wurde versucht, eine Datei mit einem falschen Format 
zu laden. (Ausnahme von HRESULT: 0x8007000B)" BadImageFormatException``` ausgeworfen werden, dann versucht man die 64-bit DLL in einer 32-bit PowerShell zu öffnen (oder umgekehrt), was nicht funktioniert.

Mit dem Programm ```link.exe``` kann man auch gucken, wie es in der DLL aussieht:

```
"C:\Program Files (x86)\Microsoft Visual Studio\2019\Community\VC\Tools\MSVC\14.28.29910\bin\Hostx64\x64\link.exe" /dump /exports addiere.dll
[...]
Dump of file addiere.dll

File Type: DLL

  Section contains the following exports for addiere.dll

[...]

    ordinal hint RVA      name

          1    0 00001000 addiere
```

Damit bekommt man allerdings nicht heraus, welche Parameter die Funktion erwartet. Das muss man wissen oder in der entsprechenden Windows-API-Referenz
(wenn es sich um eine Microsoft Windows DLL handelt) herausfinden.
