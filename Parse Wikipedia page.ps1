#Parse Wikipedia page

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


$url = "https://en.wikipedia.org/wiki/Visa_requirements_for_Russian_citizens"


$str_insert = 'INSERT INTO `visa`(`country`, `visa_type`, `notes`) VALUES '
$sql_insert = ""

$state1 = 'Visa required'
$state2 = 'Visa not required'
$state3 = 'Visa on arrival'
$state4 = 'eVisa / Visa on arrival'
$state5 = 'eVisa / Free visa on arrival'
$state6 = 'eVisa'
$state6_2 = 'e-Visa'
$state7 = 'Electronic Authorization'
$state8 = 'Online Visa'
$state9 = 'Restricted area'
$state10 = 'Special permit required'
$state11 = 'Permit required'
$state12 = 'Admission refused'
$state13 = 'Entry permit required'

$visa_type = @{}
$visa_type.add($state1,1)
$visa_type.add($state2,2)
$visa_type.add($state3,3)
$visa_type.add($state4,4)
$visa_type.add($state5,5)
$visa_type.add($state6,6)
$visa_type.add($state6_2,6)
$visa_type.add($state7,7)
$visa_type.add($state8,8)
$visa_type.add($state9,9)
$visa_type.add($state10,10)
$visa_type.add($state11,11)
$visa_type.add($state12,12)
$visa_type.add($state13,13)


$WebRequest = Invoke-WebRequest -Uri $url -Method GET -ContentType "text/plain; charset=utf-8"
$Table_tag = $WebRequest.AllElements | where {($_.tagName -eq "table")}
$content = $Table_tag[0].innerHTML
$str = $Table_tag[0].innerHTML -split '</TD></TR>'

$td = $country = $v_type = $AllowedStay = $notes = ''

foreach ($s in $str) {

    $td = $s -split '</TD>'
    if ($td.count -eq 5) {
        $td[0] -match 'href\=\".+\"\>(?<country>.+)\<\/A\>.$' >> $null
        $country = $Matches["country"]
        $country

      
        if ($td[1] -like "*$state1*") { $v_type = $visa_type[$state1] }
        elseif ($td[1] -like "*$state2*") { $v_type = $visa_type[$state2] }
        elseif ($td[1] -like "*$state3*") { $v_type = $visa_type[$state3] }
        elseif ($td[1] -like "*$state4*") { $v_type = $visa_type[$state4] }
        elseif ($td[1] -like "*$state5*") { $v_type = $visa_type[$state5] }
        elseif ($td[1] -like "*$state6*") { $v_type = $visa_type[$state6] }
        elseif ($td[1] -like "*$state6_2*") { $v_type = $visa_type[$state6_2] }
        elseif ($td[1] -like "*$state7*") { $v_type = $visa_type[$state7] }
        elseif ($td[1] -like "*$state8*") { $v_type = $visa_type[$state8] }
        elseif ($td[1] -like "*$state9*") { $v_type = $visa_type[$state9] }
        elseif ($td[1] -like "*$state10*") { $v_type = $visa_type[$state10] }
        elseif ($td[1] -like "*$state11*") { $v_type = $visa_type[$state11] }
        elseif ($td[1] -like "*$state12*") { $v_type = $visa_type[$state12] }
        elseif ($td[1] -like "*$state13*") { $v_type = $visa_type[$state13] }
        $v_type


        
        if ($td[2] -like '*SUP*') { $td[2] -match '\<TD\>(?<AllowedStay>.+)\<SUP\S' >> $null }
        else { $td[2] -match '\<TD\>(?<AllowedStay>.+)' >> $null }
        if ($Matches["AllowedStay"] -like '*<BR>*') { $AllowedStay = $Matches["AllowedStay"].Replace('<BR>','') }
        else { $AllowedStay = $Matches["AllowedStay"] } 
        $AllowedStay

        $notes = $td[3].Replace('<TD>','')
        $notes

    } elseif ($td.count -eq 4) {

        Write-Host $td.count -ForegroundColor Green
        $td[0] -match 'href\=\".+\"\>(?<country>.+)\<\/A\>.$' >> $null
        $country = $Matches["country"]
        $country

        if ($td[1] -like "*$state1*") { $v_type = $visa_type[$state1] }
        elseif ($td[1] -like "*$state2*") { $v_type = $visa_type[$state2] }
        elseif ($td[1] -like "*$state3*") { $v_type = $visa_type[$state3] }
        elseif ($td[1] -like "*$state4*") { $v_type = $visa_type[$state4] }
        elseif ($td[1] -like "*$state5*") { $v_type = $visa_type[$state5] }
        elseif ($td[1] -like "*$state6*") { $v_type = $visa_type[$state6] }
        elseif ($td[1] -like "*$state6_2*") { $v_type = $visa_type[$state6_2] }
        elseif ($td[1] -like "*$state7*") { $v_type = $visa_type[$state7] }
        elseif ($td[1] -like "*$state8*") { $v_type = $visa_type[$state8] }
        elseif ($td[1] -like "*$state9*") { $v_type = $visa_type[$state9] }
        elseif ($td[1] -like "*$state10*") { $v_type = $visa_type[$state10] }
        elseif ($td[1] -like "*$state11*") { $v_type = $visa_type[$state11] }
        elseif ($td[1] -like "*$state12*") { $v_type = $visa_type[$state12] }
        elseif ($td[1] -like "*$state13*") { $v_type = $visa_type[$state13] }
        $v_type


        $notes = $td[2].Replace('<TD colSpan=2>','')
        $notes

    }


    $sql_insert += $str_insert + "('" + $country + "', " + $v_type + ", '" + $AllowedStay + "', '" + $notes + "');
"

    $td = $country = $v_type = $AllowedStay = $notes = ''
}


Write-Host $sql_insert -ForegroundColor Green

$sql_insert > "C:\sql_wiki_visa_for_russian.sql"


