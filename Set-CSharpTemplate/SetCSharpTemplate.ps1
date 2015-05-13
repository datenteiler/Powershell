$Assem = ( 
    # add referenced assemblies found with:
    # $assemblyPath = "C:\Windows\Microsoft.NET\Framework\v2.0.50727\System.dll" 
    # [System.Reflection.AssemblyName]::GetAssemblyName($assemblyPath).FullName

    "System, Version=2.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089"
    ) 

$Source = @" 
// add C# source code

using System;

namespace HelloWorld
{
    public static class Hello 
    {
        public static void Get() 
        {
            Console.WriteLine("Hello World!");

        }
    }
}
"@ 

Add-Type -ReferencedAssemblies $Assem -TypeDefinition $Source -Language CSharp 
[HelloWorld.Hello]::Get()
