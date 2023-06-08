#Yandex raspisanie

$path = 'C:\TheLooch\rasp\rasp.json'
$result_path = "C:\TheLooch\rasp\country"

$str_insert = 'INSERT INTO `ya_raspisanie`(`country_title`, `country_code`, `region_title`, `region_code`, `settlements_title`, `settlements_code`, `stations_direction`, `stations_code`, `stations_station_type`, `stations_transport_type`, `stations_title`, `stations_longitude`, `stations_latitude`) VALUES '

$sql_insert = $country_title = $country_code = $region_title = $region_code = $settlements_title = $settlements_code = $stations_direction = $stations_code = $stations_station_type = $stations_transport_type = $stations_title = $stations_longitude = $stations_latitude = ''


$json = gc $path -Encoding UTF8 | ConvertFrom-Json


foreach ($j in $json.countries) {

    $country_title = $j.title
    $country_code = $j.codes.yandex_code

    foreach($regions in $j.regions) {
        
        $region_title = $regions.title -replace "'",""
        $region_code = $regions.codes.yandex_code
        foreach($settlements in $regions.settlements) {
            $settlements_title = $settlements.title -replace "'",""
            $settlements_code = $settlements.codes.yandex_code
            foreach($stations in $settlements.stations) {
                $stations_direction = $stations.direction -replace "'",""
                $stations_code = $stations.codes.yandex_code
                $stations_station_type = $stations.station_type
                $stations_transport_type = $stations.transport_type
                $stations_title = $stations.title -replace "'",""
                $stations_longitude = $stations.longitude
                $stations_latitude = $stations.latitude


                $sql_insert += $str_insert + "('" + $country_title + "', '" + $country_code + "', '" + $region_title + "', '" + $region_code + "', '" + $settlements_title + "', '" + $settlements_code + "', '" + $stations_direction + "', '" + $stations_code + "', '" + $stations_station_type + "', '" + $stations_transport_type + "', '" + $stations_title + "', '" + $stations_longitude + "', '" + $stations_latitude + "');
"

                Write-Host $sql_insert -ForegroundColor Green

                $settlements_title = $settlements_code = $stations_direction = $stations_code = $stations_station_type = $stations_transport_type = $stations_title = $stations_longitude = $stations_latitude = ''



            }

            $region_title = $region_code = ''

        }



    }


    $sql_insert > "$result_path\title\sql_$(random(999))_rasp_$country_title.sql"
    $sql_insert > "$result_path\code\sql_$(random(999))_rasp_$country_code.sql"
    $country_title = $country_code = $sql_insert = ''


}

#$sql_insert > "$result_path\sql_rasp2.sql"