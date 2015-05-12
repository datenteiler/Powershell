Imports System.Management.Automation ' Windows PowerShell assembly

Namespace ShowGreeting
    ' Declare the class as a cmdlet and specify and 
    ' appropriate verb and noun for the cmdlet name.
    <Cmdlet(VerbsCommon.Show, "Greeting")> _
    Public Class SendGreetingCommand
        Inherits Cmdlet

        ' Declare the parameter for the cmdlet
        Private _Name As String()
        <Parameter(Position:=0, Mandatory:=True), ValidateNotNullOrEmpty()> _
        Public Property Name() As String() ' Sets name of parameter
            Get
                Return _Name
            End Get
            Set(ByVal value As String())
                _Name = value
            End Set
        End Property

        ' Overide the ProcessRecord method to process
        ' the supplied user name and write out a 
        ' greeting to the user by calling the WriteObject
        'method.
        Protected Overrides Sub ProcessRecord()
            ' Convert _Name to string 
            Dim strName As String = String.Join(" ", _Name)
            WriteObject("Hallo " + strName + "!")
        End Sub
    End Class
End Namespace

'' Windows SDK is needed, compile:
'' vbc /nologo /reference:"C:\Program Files\Reference Assemblies\Microsoft\WindowsPowerShell\v1.0\System.Management.Automation.dll" /target:library /out:ShowGreeting.dll ShowGreeting.vb
