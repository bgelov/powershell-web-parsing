#travelpayouts routes https://support.travelpayouts.com/hc/ru/articles/203956163#09

$result_path = 'C:\TheLooch'
$str_insert = 'INSERT INTO `routes`(`airline_iata`, `airline_icao`, `departure_airport_iata`, `departure_airport_icao`, `arrival_airport_iata`, `arrival_airport_icao`, `codeshare`, `transfers`, `planes`) VALUES '
$sql_insert = ""

$url = 'http://api.travelpayouts.com/data/routes.json'
$wc = New-Object System.Net.WebClient
$wc.Encoding = [System.Text.Encoding]::UTF8
$json = ($wc.DownloadString($url)) | ConvertFrom-Json

foreach ($j in $json) {

<#
    $j.airline_iata
    $j.airline_icao
    $j.departure_airport_iata
    $j.departure_airport_icao
    $j.arrival_airport_iata
    $j.arrival_airport_icao
    $j.codeshare
    $j.transfers
    $j.planes
#>

    $sql_insert += $str_insert + "('" + $j.airline_iata + "', '" + $j.airline_icao + "', '" + $j.departure_airport_iata + "', '" + $j.departure_airport_icao + "', '" + $j.arrival_airport_iata + "', '" + $j.arrival_airport_icao + "', '" + $j.codeshare + "', '" + $j.transfers + "', '" + $j.planes + "');
"

}

$sql_insert > "$result_path\sql_routes.sql"