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
