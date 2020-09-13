Add-Type -Path System.Data.SQLite.dll
$conn = New-Object -TypeName System.Data.SQLite.SQLiteConnection
$conn.ConnectionString = "data source=Geburtstage.sqlite" 
$conn.Open()
$sqlcmd = $conn.CreateCommand()
$sqlcmd.CommandText = @'
DROP TABLE IF EXISTS Geburtstage; CREATE TABLE Geburtstage (
    Name VARCHAR(20) PRIMARY KEY,
    Vorname TEXT,
    Nachname TEXT,
    Geburtstag DATETIME)
'@
$null = $sqlcmd.ExecuteNonQuery()
$sqlcmd.CommandText = @'
INSERT INTO Geburtstage (
    Name,  
    Vorname,
    Nachname, 
    Geburtstag) 
VALUES ("Nikki Sixx", "Nikki", "Sixx", "1958-12-11"),
("Vince Neil", "Vince", "Neil", "1961-02-08"),
("Mick Mars", "Mick", "Mars", "1951-05-04"),
("Tommy Lee", "Tommy", "Lee", "1962-10-03")
'@
$null = $sqlcmd.ExecuteNonQuery()
$sqlcmd.CommandText = @'
SELECT Name, Geburtstag FROM Geburtstage ORDER BY Geburtstag
'@
#SELECT Name, strftime("%d.%m.%Y", date(Geburtstag)) AS Geburtstag FROM Geburtstage ORDER BY date(Geburtstag);
$adapter = New-Object -TypeName System.Data.SQLite.SQLiteDataAdapter $sqlcmd
$data = New-Object System.Data.DataSet
$null = $adapter.Fill($data)
$table = $data.Tables
ForEach ($t in $table){
    $t
}
$sqlcmd.Dispose()
$conn.Dispose()
