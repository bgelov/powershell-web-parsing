#travelpayouts airports https://support.travelpayouts.com/hc/ru/articles/203956163#09

$str_insert = 'INSERT INTO `airports`(`time_zone`, `name`, `flightable`, `coordinates_lon`, `coordinates_lat`, `code`, `name_translations_en`, `country_code`, `city_code`) VALUES '
$sql_insert = ""

$url = 'http://api.travelpayouts.com/data/ru/airports.json'
$wc = New-Object System.Net.WebClient
$wc.Encoding = [System.Text.Encoding]::UTF8
$json = ($wc.DownloadString($url)) | ConvertFrom-Json

foreach ($j in $json) {

<#    
    $j.time_zone
    $j.name
    $j.flightable
    $j.coordinates.lon
    $j.coordinates.lat
    $j.code
    $j.name_translations.en
    $j.country_code
    $j.city_code
#>

    $j.name = $j.name -replace "'",""
    $j.name_translations.en = $j.name_translations.en -replace "'",""


    $sql_insert += $str_insert + "('" + $j.time_zone + "', '" + $j.name + "', '" + $j.flightable + "', '" + $j.coordinates.lon + "', '" + $j.coordinates.lat + "', '" + $j.code + "', '" + $j.name_translations.en + "', '" + $j.country_code + "', '" + $j.city_code + "');
"

}

$sql_insert = $sql_insert -Replace '&#039;',""

$sql_insert > "C:\TheLooch\sql_airports.sql"


