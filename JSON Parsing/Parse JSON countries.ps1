#travelpayouts countries https://support.travelpayouts.com/hc/ru/articles/203956163#09

$str_insert = 'INSERT INTO `countries` (`name`, `currency`, `code`, `cases_vi`, `cases_tv`, `cases_ro`, `cases_pr`, `cases_da`, `name_translations_en`) VALUES '
$sql_insert = ""

$url = 'http://api.travelpayouts.com/data/ru/countries.json'
$wc = New-Object System.Net.WebClient
$wc.Encoding = [System.Text.Encoding]::UTF8
$json = ($wc.DownloadString($url)) | ConvertFrom-Json

foreach ($j in $json) {
    
<#
    $j.name
    $j.currency
    $j.code
    $j.cases.vi
    $j.cases.tv
    $j.cases.ro
    $j.cases.pr
    $j.cases.da
    $j.name_translations.en
#>
    
    $j.name = $j.name -replace "'",""
    $j.cases.vi = $j.cases.vi -replace "'",""
    $j.cases.tv = $j.cases.tv -replace "'",""
    $j.cases.ro = $j.cases.ro -replace "'",""
    $j.cases.pr = $j.cases.pr -replace "'",""
    $j.cases.da = $j.cases.da -replace "'",""
    $j.name_translations.en = $j.name_translations.en -replace "'",""

    if ($j.name -eq 'Крым') { $j.currency = 'RUB' }
    if (!($j.currency)) { $j.currency = 'XXX' }

    $sql_insert += $str_insert + "('" + $j.name + "', '" + $j.currency + "', '" + $j.code + "', '" + $j.cases.vi + "', '" + $j.cases.tv + "', '" + $j.cases.ro + "', '" + $j.cases.pr + "', '" + $j.cases.da + "', '" + $j.name_translations.en + "');
"

}

$sql_insert = $sql_insert -Replace '&#039;',""

$sql_insert > "C:\TheLooch\sql_countries.sql"