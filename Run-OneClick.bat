@echo off
setlocal
powershell.exe -NoLogo -NoProfile -ExecutionPolicy Bypass -File "%~dp0Get-WindowsActivationDiagnostics.ps1"
set "RC=%ERRORLEVEL%"
echo.
echo Windows Activation Diagnostics finished with exit code %RC%.
pause
exit /b %RC%
