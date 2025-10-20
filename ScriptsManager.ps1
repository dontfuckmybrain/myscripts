cls
Clear-Host
Write-Host "░██████╗░█████╗░██████╗░██╗██████╗░████████╗░██████╗  ███╗░░░███╗░█████╗░███╗░░██╗░█████╗░░██████╗░███████╗██████╗░" -ForegroundColor Blue
Write-Host "██╔════╝██╔══██╗██╔══██╗██║██╔══██╗╚══██╔══╝██╔════╝  ████╗░████║██╔══██╗████╗░██║██╔══██╗██╔════╝░██╔════╝██╔══██╗" -ForegroundColor Blue
Write-Host "╚█████╗░██║░░╚═╝██████╔╝██║██████╔╝░░░██║░░░╚█████╗░  ██╔████╔██║███████║██╔██╗██║███████║██║░░██╗░█████╗░░██████╔╝" -ForegroundColor Blue
Write-Host "░╚═══██╗██║░░██╗██╔══██╗██║██╔═══╝░░░░██║░░░░╚═══██╗  ██║╚██╔╝██║██╔══██║██║╚████║██╔══██║██║░░╚██╗██╔══╝░░██╔══██╗" -ForegroundColor Blue
Write-Host "██████╔╝╚█████╔╝██║░░██║██║██║░░░░░░░░██║░░░██████╔╝  ██║░╚═╝░██║██║░░██║██║░╚███║██║░░██║╚██████╔╝███████╗██║░░██║" -ForegroundColor Blue
Write-Host "╚═════╝░░╚════╝░╚═╝░░╚═╝╚═╝╚═╝░░░░░░░░╚═╝░░░╚═════╝░  ╚═╝░░░░░╚═╝╚═╝░░╚═╝╚═╝░░╚══╝╚═╝░░╚═╝░╚═════╝░╚══════╝╚═╝░░╚═╝" -ForegroundColor Blue


$scriptList = @(
    @{ Name = "HabibiModAnalyzer"; Url = "https://raw.githubusercontent.com/HadronCollision/PowershellScripts/refs/heads/main/HabibiModAnalyzer.ps1" },
    @{ Name = "TaskSchedulerParser"; Url = "https://raw.githubusercontent.com/ObsessiveBf/Task-Scheduler-Parser/main/script.ps1" },
    @{ Name = "RedLotusPrefetchAnalyzer"; Url = "https://raw.githubusercontent.com/bacanoicua/Screenshare/main/RedLotusPrefetchIntegrityAnalyzer.ps1" },
    @{ Name = "GetHarddiskVolumes"; Url = "https://raw.githubusercontent.com/dontfuckmybrain/myscripts/refs/heads/main/GetHarddiskVolumes.ps1" },
    @{ Name = "ServiceCheck"; Url = "https://raw.githubusercontent.com/dontfuckmybrain/myscripts/refs/heads/main/ServiceCheck.ps1" },
    @{ Name = "DllsCheck"; Url = "https://raw.githubusercontent.com/dontfuckmybrain/myscripts/refs/heads/main/Dlls.ps1" }
    @{ Name = "ConvertMPLogToCSV"; Url = "https://github.com/dontfuckmybrain/myscripts/raw/refs/heads/main/ConvertMPLogToCSV.ps1" }
    @{ Name = "DoomsdayFinder"; Url = "https://github.com/dontfuckmybrain/myscripts/raw/refs/heads/main/DoomsdayFinder.ps1" }
    @{ Name = "RecChecker"; Url = "https://github.com/dontfuckmybrain/myscripts/raw/refs/heads/main/RecChecker.ps1" }
)


Write-Host "`n`n`nДоступные скрипты:`n"
for ($i = 0; $i -lt $scriptList.Count; $i++) {
    Write-Host "$($i + 1)) $($scriptList[$i].Name)"
}

$input = Read-Host "`nВведите номера скриптов через запятую (например, 1,3,5)`n"
$indices = $input -split "," | ForEach-Object { ($_ -as [int]) - 1 }

foreach ($index in $indices) {
    if ($index -ge 0 -and $index -lt $scriptList.Count) {
        $script = $scriptList[$index]
        Write-Host "`n[+] Загружаю и выполняю скрипт: $($script.Name)`n"
        try {
            $code = Invoke-RestMethod -Uri $script.Url
            Invoke-Expression $code
            Read-Host "Нажмите Enter для продолжения..."
        } catch {
            Write-Warning "Ошибка при загрузке или выполнении скрипта '$($script.Name)': $_"
        }
    } else {
        Write-Warning "Неверный номер скрипта: $($index + 1)"
    }
}

