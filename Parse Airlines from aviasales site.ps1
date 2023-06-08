#Parse Airlines from aviasales site

#https ===============
add-type @"
    using System.Net;
    using System.Security.Cryptography.X509Certificates;
    public class TrustAllCertsPolicy : ICertificatePolicy {
        public bool CheckValidationResult(
            ServicePoint srvPoint, X509Certificate certificate,
            WebRequest request, int certificateProblem) {
            return true;
        }
    }
"@
[System.Net.ServicePointManager]::CertificatePolicy = New-Object TrustAllCertsPolicy

[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Ssl3, [Net.SecurityProtocolType]::Tls, [Net.SecurityProtocolType]::Tls11, [Net.SecurityProtocolType]::Tls12
#==================================

$csv = $airline_address = $airline_phone = $airline_iata = $airline_website = ''
$result_path = "C:\TheLooch\TheLoochAS"
$fileName = "airlines_info.sql"

Remove-Item "$result_path\$fileName"
New-Item "$result_path\$fileName"



$url = 'http://www.aviasales.ru/sitemap/airlines.xml'

$wc = New-Object System.Net.WebClient
$wc.Encoding = [System.Text.Encoding]::UTF8
[xml]$json = ($wc.DownloadString($url))

#Получаем все ссылки из карты сайта
$allLinks = $json.urlset.url.loc

foreach ($xurl in $allLinks) {
    Start-Sleep -Seconds 2
    $WebRequest = Invoke-WebRequest -Uri $xurl -Method GET -ContentType "text/plain; charset=utf-8"
    $UL_tag = $WebRequest.AllElements | where {($_.tagName -eq "ul") -and ($_.class -eq "airline-card__list")}
    $content = $UL_tag.innerText.replace("'",'').replace('`','')

    $content -match "Адрес\:\s(?<address>.+)"

    $airline_address = $Matches["address"].Trim().Trim('.')

    $content -match "Телефон\:\s(?<phone>.+)"

    if ($Matches["phone"]) {
        $airline_phone = $Matches["phone"].Trim().Trim('.').Trim('+').Replace(" ","").Replace("-","").Replace("(","").Replace(")","")
    }

    $content -match "Код ИАТА\:\s(?<iata>.+)"

    $airline_iata = $Matches["iata"].Trim().Trim('.')

    $content -match "\/\/(?<website>.+)"

    $airline_website = $Matches["website"].Trim().Trim('/')
    if ($airline_website -ne '') { $airline_website = 'https://' + $airline_website }

    #$str = $airline_iata + ';' + $airline_address + ';' + $airline_phone + ';' + $airline_website + ''

    if (($airline_iata -ne '') -and (!(($airline_address -eq '') -and ($airline_phone -eq '') -and ($airline_website-eq '')))) {

        $str = 'UPDATE `airlines` SET `home_link`=' + "'" + $airline_website + "'" + ',`address`=' + "'" + $airline_address + "'" + ',`phone`=' + "'" + $airline_phone + "'" + ' WHERE `code`=' + "'"+$airline_iata+"';"

        $str = $str.Replace("`phone`='7800","`phone`='8800").Replace("`phone`='7495","`phone`='+7495").Replace("`phone`='7499","`phone`='+7499")
        Write-Host $str -ForegroundColor Green

        Add-Content -Path "$result_path\$fileName" -Value $str

    }

    $airline_address = $airline_phone = $airline_iata = $airline_website = ''

}


