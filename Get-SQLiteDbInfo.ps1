<#
.Synopsis
   Prints Information of a SQLite database.
.DESCRIPTION
 
.EXAMPLE
   Get-SQLiteDbInfo -librarypath "\path\to\System.Data.SQLite.dll" -datasource "\path\to\database.sqlite"
#>

function Test-Integrity
{
    Begin
    {
        $sql = $con.CreateCommand()
        $sql.CommandText = "PRAGMA INTEGRITY_CHECK"
    }
    Process
    {
        $adapter = New-Object -TypeName System.Data.SQLite.SQLiteDataAdapter $sql
        $data = New-Object System.Data.DataSet
        [void]$adapter.Fill($data)
        $data.Tables[0]
    }
    End
    {
        $sql.Dispose()
    }
}

function Get-TableInfo
{
    Begin
    {
        $sql = $con.CreateCommand()
        $sql.CommandText = "SELECT * FROM sqlite_master"
    }
    Process
    {
        $adapter = New-Object -TypeName System.Data.SQLite.SQLiteDataAdapter $sql
        $data = New-Object System.Data.DataSet
        [void]$adapter.Fill($data)
        $data.Tables[0] | ft -AutoSize
    }
    End
    {
        $sql.Dispose()
    }
}

function Get-SQLiteDbInfo
{
    [CmdletBinding()]
    [OutputType([int])]
    Param
    (
        # Set sqlite library path
        [Parameter(Mandatory=$true,
                   Position=0)]
        $librarypath,

        # path to database
        [Parameter(Mandatory=$true)]
        $database
    )
    Begin
    {
        Add-Type -Path $librarypath
        $con = New-Object -TypeName System.Data.SQLite.SQLiteConnection
        $con.ConnectionString = "Data Source=$database"
        $con.Open()
    }
    Process
    {
        Test-Integrity
        Get-TableInfo
    }
    End
    {
        $con.Close()
    }
}
