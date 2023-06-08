#Parse ourairports.com
#https://ourairports.com/data/
<#

INSERT INTO `ourairports`(`id`, `ident`, `type`, `name`, `latitude_deg`, `longitude_deg`, `elevation_ft`, `continent`, `iso_country`, `iso_region`, `municipality`, `scheduled_service`, `gps_code`, `iata_code`, `local_code`, `home_link`, `wikipedia_link`, `keywords`) VALUES ([value-1],[value-2],[value-3],[value-4],[value-5],[value-6],[value-7],[value-8],[value-9],[value-10],[value-11],[value-12],[value-13],[value-14],[value-15],[value-16],[value-17],[value-18])

#>

$url = 'http://ourairports.com/data/airports.csv'
$result_path = "C:\TheLooch"
$fileName = "sql_ourairports.sql"
Remove-Item "$result_path\$fileName"
New-Item "$result_path\$fileName"

$str_insert = 'INSERT INTO `ourairports`(`id`, `ident`, `type`, `name`, `latitude_deg`, `longitude_deg`, `elevation_ft`, `continent`, `iso_country`, `iso_region`, `municipality`, `scheduled_service`, `gps_code`, `iata_code`, `local_code`, `home_link`, `wikipedia_link`, `keywords`) VALUES '

$wc = New-Object System.Net.WebClient
$wc.Encoding = [System.Text.Encoding]::UTF8
$csv = ($wc.DownloadString($url)) | ConvertFrom-Csv

foreach ($airport in $csv) {

    $airport_id = $airport.id
    $airport_ident = $airport.ident -replace "'",'`'
    $airport_type = $airport.type -replace "'",'`'
    $airport_name = $airport.name -replace "'",'`'
    $airport_elevation_ft = $airport.elevation_ft -replace "'",'`'
    $airport_scheduled_service = $airport.scheduled_service -replace "'",'`'
    $airport_latitude_deg = $airport.latitude_deg
    $airport_longitude_deg = $airport.longitude_deg
    $airport_gps_code = $airport.gps_code -replace "'",'`'
    $airport_municipality  = $airport.municipality -replace "'",'`'
    $airport_wikipedia_link = $airport.wikipedia_link -replace "'",'`'
    $airport_local_code = $airport.local_code -replace "'",'`'
    $airport_home_link = $airport.home_link -replace "'",'`'
    $airport_keywords = $airport.keywords -replace "'",'`'
    $airport_iata_code = $airport.iata_code
    $airport_continent = $airport.continent
    $airport_iso_country = $airport.iso_country
    $airport_iso_region = $airport.iso_region

    $airport_name

    $sql_insert = $str_insert + "(" + $airport_id + ", '" + $airport_ident + "', '" + $airport_type + "', '" + $airport_name + "', '" + $airport_latitude_deg + "', '" + $airport_longitude_deg + "', '" + $airport_elevation_ft + "', '" + $airport_continent + "', '" + $airport_iso_country + "', '" + $airport_iso_region + "', '" + $airport_municipality + "', '" + $airport_scheduled_service + "', '" + $airport_gps_code + "', '" + $airport_iata_code + "', '" + $airport_local_code + "', '" + $airport_home_link + "', '" + $airport_wikipedia_link + "', '" + $airport_keywords + "');"
    Add-Content -Path "$result_path\$fileName" -Value $sql_insert

    $sql_insert = $airport_iso_region = $airport_iso_country = $airport_continent = $airport_iata_code = $airport_keywords = $airport_home_link = $airport_local_code = $airport_wikipedia_link = $airport_municipality = $airport_gps_code = $airport_longitude_deg = $airport_latitude_deg = $airport_id = $airport_ident = $airport_type = $airport_name = $airport_elevation_ft = $airport_scheduled_service = ''

                
}


function OutInUTF8($File){
    $FileRawString = Get-Content -Raw $File
    $Utf8NoBomEncoding = New-Object System.Text.UTF8Encoding $False
    [System.IO.File]::WriteAllLines($File, $FileRawString, $Utf8NoBomEncoding)
}

OutInUTF8 "$result_path\$fileName"