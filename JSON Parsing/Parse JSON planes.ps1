#travelpayouts planes https://support.travelpayouts.com/hc/ru/articles/203956163#09

$str_insert = 'INSERT INTO `planes`(`code`, `name`) VALUES '
$sql_insert = ""

$url = 'http://api.travelpayouts.com/data/planes.json'
$wc = New-Object System.Net.WebClient
$wc.Encoding = [System.Text.Encoding]::UTF8
$json = ($wc.DownloadString($url)) | ConvertFrom-Json

foreach ($j in $json) {

<#  
    $j.code
    $j.name
#>

    $j.name = $j.name -replace "'",""

    $sql_insert += $str_insert + "('" + $j.code + "', '" + $j.name + "');
"

}

$sql_insert = $sql_insert -Replace '&#039;',""

$sql_insert > "C:\TheLooch\sql_planes.sql"


