$version = "1.0"
$Host.UI.RawUI.WindowTitle = "Record Checker v$version ($(Get-Date -Format 'dd.MM.yyyy'))"

# Clear screen and display banner
Clear-Host
Write-Host ""
Write-Host ""
Write-Host ""
Write-Host "    ███╗░░░███╗░█████╗░██╗░░░██╗░██████╗░██████╗███████╗" -ForegroundColor Magenta
Write-Host "    ████╗░████║██╔══██╗██║░░░██║██╔════╝██╔════╝██╔════╝" -ForegroundColor Magenta
Write-Host "    ██╔████╔██║██║░░██║██║░░░██║╚█████╗░╚█████╗░█████╗░░" -ForegroundColor Magenta
Write-Host "    ██║╚██╔╝██║██║░░██║██║░░░██║░╚═══██╗░╚═══██╗██╔══╝░░" -ForegroundColor Magenta
Write-Host "    ██║░╚═╝░██║╚█████╔╝╚██████╔╝██████╔╝██████╔╝███████╗" -ForegroundColor Magenta
Write-Host "    ╚═╝░░░░░╚═╝░╚════╝░░╚═════╝░╚═════╝░╚═════╝░╚══════╝" -ForegroundColor Magenta
Write-Host ""
Write-Host ""


$processes = @(
    "psr", "mirillis", "wmcap", "playclaw", "XSplit", "Screencast", 
    "camtasia", "dxtory", "nvcontainer", "obs64", "bdcam", "RadeonSettings", 
    "Fraps", "CamRecorder", "XSplit.Core", "ShareX", "Action", "lightstream", 
    "streamlabs", "webrtcvad", "openbroadcastsoftware", "movavi.screen.recorder", 
    "icecreamscreenrecorder", "smartpixel", "d3dgear", "gadwinprintscreen", 
    "apowersoftfreescreenrecorder", "bandicamlauncher", "hypercam", 
    "loiloilgamerecorder", "nchexpressions", "captura", "vokoscreenNG", 
    "simple.screen.recorder", "recordmydesktop", "kazam", "gtk-recordmydesktop", 
    "screenstudio", "screenkey", "jupyter-notebook"
)

Write-Host "Checking for recording/streaming software..." -ForegroundColor Cyan
Write-Host ""

$foundProcesses = @()

foreach ($process in $processes) {
    $processName = if ($process -notmatch "\.exe$") { "$process.exe" } else { $process }
    
    # Check if process is running
    $runningProcess = Get-Process -Name $process -ErrorAction SilentlyContinue
    if ($runningProcess) {
        Write-Host "  $process Is Recording" -ForegroundColor Yellow
        $foundProcesses += $process
    }
}

if ($foundProcesses.Count -eq 0) {
    Write-Host "  No recording software detected" -ForegroundColor Green
} else {
    Write-Host ""
    Write-Host "  Found $($foundProcesses.Count) potential recording process(es)" -ForegroundColor Red
}