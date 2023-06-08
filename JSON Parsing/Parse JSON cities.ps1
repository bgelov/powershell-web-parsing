#travelpayouts cities https://support.travelpayouts.com/hc/ru/articles/203956163#09

$str_insert = 'INSERT INTO `cities`(`time_zone`, `name`, `coordinates_lon`, `coordinates_lat`, `code`, `cases_vi`, `cases_tv`, `cases_ro`, `cases_pr`, `cases_da`, `name_translations_en`, `country_code`) VALUES '
$sql_insert = ""

$url = 'http://api.travelpayouts.com/data/ru/cities.json'
$wc = New-Object System.Net.WebClient
$wc.Encoding = [System.Text.Encoding]::UTF8
$json = ($wc.DownloadString($url)) | ConvertFrom-Json

foreach ($j in $json) {
    

<#
    $j.time_zone
    $j.name
    $j.coordinates.lon
    $j.coordinates.lat
    $j.code
    $j.cases.vi
    $j.cases.tv
    $j.cases.ro
    $j.cases.pr
    $j.cases.da
    $j.name_translations.en
    $j.country_code
#>    

    $j.name = $j.name -replace "'",""
    $j.cases.vi = $j.cases.vi -replace "'",""
    $j.cases.tv = $j.cases.tv -replace "'",""
    $j.cases.ro = $j.cases.ro -replace "'",""
    $j.cases.pr = $j.cases.pr -replace "'",""
    $j.cases.da = $j.cases.da -replace "'",""
    $j.name_translations.en = $j.name_translations.en -replace "'",""


    $sql_insert += $str_insert + "('" + $j.time_zone + "', '" + $j.name + "', '" + $j.coordinates.lon + "', '" + $j.coordinates.lat + "', '" + $j.code + "', '" + $j.cases.vi + "', '" + $j.cases.tv + "', '" + $j.cases.ro + "', '" + $j.cases.pr + "', '" + $j.cases.da + "', '" + $j.name_translations.en + "', '" + $j.country_code + "');
"

}

$sql_insert = $sql_insert -Replace '&#039;',""

$sql_insert > "C:\TheLooch\sql_cities.sql"


