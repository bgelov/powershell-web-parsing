#travelpayouts alliances https://support.travelpayouts.com/hc/ru/articles/203956163#09

$str_insert = 'INSERT INTO `alliances`(`name`, `name_translations_en`, `airlines`) VALUES '
$sql_insert = ""

$url = 'http://api.travelpayouts.com/data/ru/alliances.json'
$wc = New-Object System.Net.WebClient
$wc.Encoding = [System.Text.Encoding]::UTF8
$json = ($wc.DownloadString($url)) | ConvertFrom-Json

foreach ($j in $json) {

<#  
    $j.name
    $j.name_translations.en
    $j.airlines
#>

    $j.name = $j.name -replace "'",""
    $j.name_translations.en = $j.name_translations.en -replace "'",""


    $sql_insert += $str_insert + "('" + $j.name + "', '" + $j.name_translations.en + "', '" + $j.airlines + "');
"

}

$sql_insert = $sql_insert -Replace '&#039;',""

$sql_insert > "C:\TheLooch\sql_alliances.sql"


