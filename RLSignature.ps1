﻿Clear-Host

Write-Host ""
function Test-Admin {;$currentUser = New-Object Security.Principal.WindowsPrincipal $([Security.Principal.WindowsIdentity]::GetCurrent());$currentUser.IsInRole([Security.Principal.WindowsBuiltinRole]::Administrator);}
if (!(Test-Admin)) {
    Write-Warning "Please Run This Script as Admin."
    Start-Sleep 10
    Exit
}

Start-Sleep -s 3

Clear-Host

$host.privatedata.ProgressForegroundColor = "red";
$host.privatedata.ProgressBackgroundColor = "black";

$pathsFilePath = "paths.txt"
if(-Not(Test-Path -Path $pathsFilePath)){
    Write-Warning "The file $pathsFilePath does not exist."
    Start-Sleep 10
    Exit
}

$paths = Get-Content "paths.txt" -Encoding UTF8
$stopwatch = [Diagnostics.Stopwatch]::StartNew()

$results = @()
$count = 0
$totalCount = $paths.Count
$progressID = 1

foreach ($path in $paths) {
    $progress = [int]($count / $totalCount * 100)
    Write-Progress -Activity "Scanning paths..." -Status "$progress% Complete:" -PercentComplete $progress -Id $progressID
    $count++

    Try {
        $filtredpath = $path.Trim()
        $fileName = Split-Path $filtredpath -Leaf
        $signatureStatus = ""
        $fileDescription = ""
        $fileSize = ""
        $isFileExist = "False"

        
        if (Test-Path -Path $filtredpath -PathType leaf) {
            $isFileExist = "True"
            $fileSize = (Get-Item $filtredpath).Length
            $signatureStatus = (Get-AuthenticodeSignature $filtredpath 2>$null).Status
            $fileDescription = (Get-Item "$filtredpath").VersionInfo.FileDescription
            
        } else {
            if (Test-Path -Path $filtredpath) {
                $isFileExist = "Path"
            } else {
                $isFileExist = "False"
            }
        }
        
    
       
        $fileDetails = New-Object PSObject
        $fileDetails | Add-Member Noteproperty Name $fileName
        $fileDetails | Add-Member Noteproperty Path $filtredpath
        $fileDetails | Add-Member Noteproperty SignatureStatus $signatureStatus
        $fileDetails | Add-Member Noteproperty FileDescription $fileDescription
        $fileDetails | Add-Member Noteproperty IsFileExist $isFileExist
        $fileDetails | Add-Member Noteproperty FileSize $fileSize
        
        $results += $fileDetails
    } Catch {
    }
}

$stopwatch.Stop()

$time = $stopwatch.Elapsed.Hours.ToString("00") + ":" + $stopwatch.Elapsed.Minutes.ToString("00") + ":" + $stopwatch.Elapsed.Seconds.ToString("00") + "." + $stopwatch.Elapsed.Milliseconds.ToString("000")

Write-Host ""
Write-Host "The scan took $time to run." -ForegroundColor Yellow

$results | Out-GridView -PassThru -Title 'Signatures Results'
