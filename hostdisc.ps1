$startRange = 1
$endRange = 255
$subnet = "192.168.0."

for ($i = $startRange; $i -le $endRange; $i++) {
    $ip = $subnet + $i
    $result = Test-Connection -ComputerName $ip -Count 1 -Quiet
    if ($result) {
        Write-Host "$ip está alcanzable"
    } else {
        Write-Host "$ip no está alcanzable"
    }
}
