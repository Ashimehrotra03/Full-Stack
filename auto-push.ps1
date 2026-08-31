$folder = "C:\Users\prart\Desktop\full stack"

$watcher = New-Object System.IO.FileSystemWatcher
$watcher.Path = $folder
$watcher.IncludeSubdirectories = $true
$watcher.EnableRaisingEvents = $true

$action = {
    Start-Sleep -Seconds 3

    Set-Location "C:\Users\prart\Desktop\full stack"

    git add .

    $changes = git status --porcelain

    if ($changes) {
        git commit -m "Auto update"
        git push
        Write-Host "Changes automatically pushed to GitHub!"
    }
}

Register-ObjectEvent $watcher Changed -Action $action
Register-ObjectEvent $watcher Created -Action $action
Register-ObjectEvent $watcher Deleted -Action $action
Register-ObjectEvent $watcher Renamed -Action $action

Write-Host "Auto Push is running... Press Ctrl+C to stop."

while ($true) {
    Start-Sleep -Seconds 1
}