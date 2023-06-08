#Download airlines logo from aviasales site
$airlines = gc 'D:\airlines\code.txt'

foreach ($airline in $airlines) {

    $url = "http://pics.avs.io/400/200/$airline.png"
    Invoke-WebRequest $url -OutFile "D:\airlines\logo\400\200\$airline.png"

}