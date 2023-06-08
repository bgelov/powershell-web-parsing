#Parse visalist.io

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


#Получаем список стран
#==================================
$sitemap_url = 'https://visalist.io/sitemap.xml'

$wc = New-Object System.Net.WebClient
$wc.Encoding = [System.Text.Encoding]::UTF8
[xml]$json = ($wc.DownloadString($sitemap_url))

#Получаем все ссылки из карты сайта
$allLinks = $json.sitemapindex.sitemap.loc

#Получаем страны из ссылок
$CountryArray = $allLinks.Replace("https://visalist.io/sitemap/","").Replace("-sitemap.xml.gz","")

foreach ($country in $CountryArray) {


    $url = "https://visalist.io/$country/visa-requirements/russia"

    #Write-Host $url -ForegroundColor Green

    Start-Sleep -Seconds 2
    $WebRequest = Invoke-WebRequest -Uri $url -Method GET -ContentType "text/plain; charset=utf-8"
    $span_tag = $WebRequest.AllElements | where {($_.tagName -eq "span") -and ($_.class -like "*v-chip theme--light v-size--small white--text ml-3*")}
    $visa = $span_tag.innerText.Trim()
    write-host "$country;$visa;"

}