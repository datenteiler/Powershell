function Get-TableInfo
{
    Begin
    {
        $sql = $con.CreateCommand()
        $sql.CommandText = "SELECT * FROM $table"
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
function Read-SqliteDB 
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
        $database,

        # path to database
        [Parameter(Mandatory=$true)]
        $table
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
        Get-TableInfo
    }
    End
    {
        $con.Close()
    }
}


$libpath = "C:\Path\To\System.Data.SQLite.dll"
$mydb = "$env:Home\mydb.sqlite"

Read-SqliteDB -librarypath $libpath -database $mydb -table "sqlite_master"
