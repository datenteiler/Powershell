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

$type = Add-Type -MemberDefinition $signature -Name Win32Addiere -PassThru 
$type::addiere(23,27)
```
