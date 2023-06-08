#travelpayouts airlines https://support.travelpayouts.com/hc/ru/articles/203956163#09

$str_insert = 'INSERT INTO `airlines`(`name`, `code`, `name_translations_en`) VALUES '
$sql_insert = ""

$url = 'http://api.travelpayouts.com/data/ru/airlines.json'
$wc = New-Object System.Net.WebClient
$wc.Encoding = [System.Text.Encoding]::UTF8
$json = ($wc.DownloadString($url)) | ConvertFrom-Json

foreach ($j in $json) {

<#    

    $j.name
    $j.code
    $j.name_translations.en

#>

    $j.name = $j.name -replace "'",""
    $j.name_translations.en = $j.name_translations.en -replace "'",""


    $sql_insert += $str_insert + "('" + $j.name + "', '" + $j.code + "', '" + $j.name_translations.en + "');
"

}

$sql_insert = $sql_insert -Replace '&#039;',""

$sql_insert > "C:\TheLooch\sql_airlines.sql"


