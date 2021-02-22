#автор Карпунин Дмитрий

cls

$ErrorActionPreference="SilentlyContinue"

$Struct = Read-Host "Инфраструктуру (1 - Внутренняя / 2 - Внешняя)"

switch ($Struct) {

    1 {$DHCPServer = "<in_dhcp_server_address>"}

    2 {$DHCPServer = "<out_dhcp_server_address>"}

}

$IPAddress = Read-Host "IP-адрес"

$IP = Get-DhcpServerv4Lease -ComputerName $DHCPServer -IPAddress $IPAddress

if (!$IP) {
    
    Write-Host "IP-адрес $IPAddress отсутствует в DHCP" -BackgroundColor Red -ForegroundColor White

} else {

    if ($IP.AddressState -like "*Reservation") {

        Write-Host "IP-адрес $IPAddress уже зарезервирован" -BackgroundColor Red -ForegroundColor White

    } else {

        $IP | Set-DhcpServerv4Reservation -ComputerName $DHCPServer

        Write-Host "IP-адрес $IPAddress зарезервирован" -ForegroundColor Green

    }

}