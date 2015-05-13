Show-Greeting
=============

The Show-Greeting Cmdlet is written in VB.NET. You need Powershell Ver. 2.0 or greater and the Windows SDK.

What you need
-------------

The assembly System.Management.Automation.dll is part of the Windows SDK and should be installed together with the SDK to:


`C:\Program Files\Reference Assemblies\Microsoft\WindowsPowerShell\v1.0\System.Management.Automation.dll`


If you use VS Express: Add a reference to that library to your project.

Now you should be able to build your project and generate a DLL file with the same name *ShowGreeting*:

```Powershell
vbc /nologo /reference:"C:\Program Files\Reference Assemblies\Microsoft\WindowsPowerShell\v1.0\System.Management.Automation.dll" /target:library /out:ShowGreeting.dll ShowGreeting.vb
```

Release DLL as Cmdlet Module
----------------------------

Create a subdirectory in your Modules directory and **name it like your DLL file**:

```Powershell
md "$(($Env:PSModulePath).Split(";")[0])\ShowGreeting" -ErrorAction SilentlyContinue
cp ShowGreeting.dll "$(($Env:PSModulePath).Split(";")[0])\ShowGreeting"
```

Create Module Manifest:

```Powershell
New-ModuleManifest "$(($Env:PSModulePath).Split(";")[0])\ShowGreeting\ShowGreeting.psd1"
```

Change the content of ShowGreeting.psd1 to something like that:

```Powershell
@{
GUID = '3be9615d-e219-4c94-92b5-997150fa9d1f' #-> Vom New-ModuleManifest ...
Author = 'Christian Imhorst'
ModuleVersion = '1.0'
PowerShellVersion="2.0"
CLRVersion="2.0"
NestedModules="ShowGreeting"
RequiredAssemblies=Join-Path $psScriptRoot "ShowGreeting.dll"
}
```

Test the Module Manifest:

```Powershell
Test-ModuleManifest "$(($Env:PSModulePath).Split(";")[0])\ShowGreeting\ShowGreeting.psd1"

ModuleType  Name          ExportedCommands
----------  ----          ----------------
Manifest    ShowGreeting  Show-Greeting
```

Import Module
-------------

```Powershell
PS> Import-Module ShowGreeting -verbose
VERBOSE: Loading module from path
'$Home\Documents\WindowsPowerShell\Modules\ShowGreeting\ShowGreeting.psd1'.
VERBOSE: Loading 'Assembly' from path
'$Home\Documents\WindowsPowerShell\Modules\ShowGreeting\ShowGreeting.dll'.
VERBOSE: Loading module from path
'$Home\Documents\WindowsPowerShell\Modules\ShowGreeting\ShowGreeting.dll'.
VERBOSE: Importing cmdlet 'Show-Greeting'.
VERBOSE: Exporting cmdlet 'Show-Greeting'.
VERBOSE: Importing cmdlet 'Show-Greeting'.
PS> Show-Greeting -Name Christian
Hello Christian!
```

How can we do this in C#
------------------------

Yes, the code in C# is similar:

```Csharp
using System.Management.Automation;  // Windows PowerShell assembly.

namespace SendGreeting
{
  // Declare the class as a cmdlet and specify and 
  // appropriate verb and noun for the cmdlet name.
  [Cmdlet(VerbsCommunications.Send, "Greeting")]
  public class SendGreetingCommand : Cmdlet
  {
    // Declare the parameters for the cmdlet.
    [Parameter(Mandatory=true)]
    public string Name
    {
      get { return name; }
      set { name = value; }
    }
    private string name;

    // Overide the ProcessRecord method to process
    // the supplied user name and write out a 
    // greeting to the user by calling the WriteObject
    // method.
    protected override void ProcessRecord()
    {
      WriteObject("Hello " + name + "!");
    }
  }
}
```

References:
-----------

https://msdn.microsoft.com/en-us/library/dd878294(v=vs.85).aspx
