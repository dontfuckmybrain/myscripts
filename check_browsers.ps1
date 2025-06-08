cls
Invoke-WebRequest -Uri "https://github.com/ZaikoARG/xxstrings/releases/download/1.0.0/xxstrings64.exe" -OutFile "xxstrings64.exe"

$process_name = Read-Host "Enter Process Name"

$puk = (Get-Process -Name $process_name).Id

foreach($smallpuk in $puk)
{
    Write-Host "Analyzing PID: $smallpuk"

    $output = (.\xxstrings64.exe -p $smallpuk | Out-String) -split "`n"
        
    foreach($out in $output) {
        if ($out -like "*https://funpay.com/orders/*") {
            Write-Host "[ ? ] Detected buy/sell" -ForegroundColor Cyan
        }
        if ($out -like "*https://funpay.com/lots/1596/*") {
            Write-Host "[ ? ] Detected 1596 lot" -ForegroundColor Yellow
        }
        if ($out -like "*https://funpay.com/account/balance*") {
            Write-Host "[ ? ] Detected balance page" -ForegroundColor Green
        }
    }
}

Remove-Item -Path "xxstrings64.exe" -Force