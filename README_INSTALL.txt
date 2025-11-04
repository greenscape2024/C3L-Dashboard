C3L Local Heartbeat & Auto-Sync Utility
---------------------------------------
Version: v1.3 (LiveConsolePulse)
Author: Project Link / Hrvoje Šajković
Repository: greenscape2024/C3L-Dashboard

Purpose:
Keeps session active (heartbeat every 60s) and automatically syncs export files
from OneDrive desktop C3L folder to Backup, GitHub sync, and GDrive sync folders.

Installation:
1. Copy script to:
   C:\Users\hsajk\OneDrive\Radna površina\GPT_GRENSCAPE_ORGANIZACIJA_BACKUP\C3L_AUTOMATION\
2. Open PowerShell (Run as Administrator).
3. Run once:
   Set-ExecutionPolicy RemoteSigned -Scope CurrentUser
4. Start script manually:
   powershell -ExecutionPolicy Bypass -File "C:\Users\hsajk\OneDrive\Radna površina\GPT_GRENSCAPE_ORGANIZACIJA_BACKUP\C3L_AUTOMATION\C3L_Local_Heartbeat_AutoSync.ps1"
5. Optional (auto-start):
   Press Win+R → type "shell:startup" → place shortcut to the .ps1 file inside that folder.

Log:
Stored in C:\Users\hsajk\Documents\C3L_LOGS\C3L_Heartbeat_Log.txt

Notes:
- Displays real-time heartbeat in PowerShell console (green text).
- Automatically creates folders if missing.
- Compatible with OneDrive ↔ GDrive sync bridge.
