$signature = @'
[DllImport("addiere.dll")]
public static extern int addiere(
          int augend,
          int addend
          );
'@ 

$type = Add-Type -MemberDefinition $signature -Name Win32Addiere -PassThru 
$type::addiere(23, 27)
