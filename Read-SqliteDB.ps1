function Read-SqliteDB 
{
  <#
      .SYNOPSIS
      Read-SqliteDB reads table of a sqlite database

      .DESCRIPTION
      Read table of a sqlite database

      .PARAMETER librarypath
      Path to System.Data.SQLite.dll

      .PARAMETER database
      Path to the sqlite database

      .PARAMETER table
      Name of the table 

      .EXAMPLE
      Read-SqliteDB -librarypath Value -database Value -table Value
      Read the table of a sqlite database

      .NOTES
      Place additional notes here.

  #>


  [OutputType([int])]
  Param
  (
    # Set sqlite library path
    [Parameter(Mandatory,HelpMessage='Path to System.Data.SQLite.dll',
    Position=0)]
    $librarypath,

    # path to database
    [Parameter(Mandatory,HelpMessage='Path to database')]
    $database,

    # name of the table
    [Parameter(Mandatory,HelpMessage='Name of the table')]
    $table
  )
  Begin
  {
    Add-Type -Path $librarypath
    $con = New-Object -TypeName System.Data.SQLite.SQLiteConnection
    $con.ConnectionString = ('Data Source={0}' -f $database)
    $con.Open()
    $sql = $con.CreateCommand()
    $sql.CommandText = ('SELECT * FROM {0}' -f $table)
  }
  Process
  {    
    $adapter = New-Object -TypeName System.Data.SQLite.SQLiteDataAdapter -ArgumentList $sql
    $data = New-Object -TypeName System.Data.DataSet
    $null = $adapter.Fill($data)
    $data.Tables[0] | Select-Object -Property *
        
  }
  End
  {
    $sql.Dispose()
    $con.Close()
  }
}
