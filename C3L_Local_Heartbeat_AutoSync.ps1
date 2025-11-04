# C3L_Local_Heartbeat_AutoSync.ps1
# Version: 1.3 (Live Console Pulse)
# Author: Project Link / Hrvoje Šajković
# Purpose: Keep session alive + auto-sync exports to Drive/GitHub/local backup (OneDrive/GDrive bridge compatible)

# --- BASE PATH SETUP ---
$DesktopPath = [Environment]::GetFolderPath('Desktop')
$Base = Join-Path $DesktopPath "GPT_GRENSCAPE_ORGANIZACIJA_BACKUP"

$SourcePath = Join-Path $Base "C3L_EXPORTS"
$BackupPath = Join-Path $Base "C3L_BACKUP_EXPORTS"
$GitHubRepo = Join-Path $Base "C3L_GITHUB_SYNC"
$DrivePath  = Join-Path $Base "C3L_SYNC_EXPORTS"

# --- LOG PATH (Documents - safe write access) ---
$LogDir  = Join-Path ([Environment]::GetFolderPath('MyDocuments')) "C3L_LOGS"
$LogPath = Join-Path $LogDir "C3L_Heartbeat_Log.txt"

# --- ENSURE DIRECTORIES EXIST ---
foreach ($p in @($BackupPath, $GitHubRepo, $DrivePath, $LogDir, $SourcePath)) {
    if (-not (Test-Path $p)) { New-Item -ItemType Directory -Force -Path $p | Out-Null }
}

# --- STARTUP MESSAGE ---
$startTime = Get-Date -Format 'yyyy-MM-dd HH:mm:ss'
Write-Output "`n--- C3L Heartbeat Started at $startTime ---" | Out-File -Append $LogPath
Write-Host "C3L Heartbeat Started at $startTime" -ForegroundColor Cyan
Write-Host "Monitoring folder: $SourcePath" -ForegroundColor Yellow
Write-Host "-----------------------------------------------------" -ForegroundColor DarkGray

# --- MAIN LOOP ---
while ($true) {
    try {
        # 1️⃣ Heartbeat
        $timestamp = Get-Date -Format 'yyyy-MM-dd HH:mm:ss'
        Write-Output "$timestamp  HEARTBEAT OK" | Out-File -Append $LogPath
        Write-Host "$timestamp  HEARTBEAT OK" -ForegroundColor Green

        # 2️⃣ File Sync
        $files = Get-ChildItem $SourcePath -File -Include *.docx, *.pdf, *.zip -ErrorAction SilentlyContinue
        foreach ($f in $files) {
            foreach ($target in @($BackupPath, $GitHubRepo, $DrivePath)) {
                $targetFile = Join-Path $target $f.Name
                if (-not (Test-Path $targetFile)) {
                    Copy-Item $f.FullName -Destination $targetFile -Force
                    $msg = "$(Get-Date -Format 'HH:mm:ss')  Copied $($f.Name) → $target"
                    Write-Output $msg | Out-File -Append $LogPath
                    Write-Host $msg -ForegroundColor DarkYellow
                }
            }
        }

        Start-Sleep -Seconds 60

    } catch {
        $errMsg = "$(Get-Date -Format 'yyyy-MM-dd HH:mm:ss')  ERROR: $($_.Exception.Message)"
        Write-Output $errMsg | Out-File -Append $LogPath
        Write-Host $errMsg -ForegroundColor Red
        Start-Sleep -Seconds 30
    }
}

Pause
