# Windows Activation Diagnostics

> **Testing note:** This was tested by me to be working. User experience may vary.

## One-click use

1. Download and extract the repository.
2. Double-click `Run-OneClick.bat`.
3. The activation report runs directly—there is no menu and licensing settings are not changed.
4. Review the exit code and reports under `C:\Users\Public\Documents\WindowsActivationDiagnostics`.

Included script: `Get-WindowsActivationDiagnostics.ps1`

## PowerShell usage

```powershell
.\Get-WindowsActivationDiagnostics.ps1
```

The script creates a read-only report of Windows edition, activation state, licence channel, partial product key and SLMGR status. It does not attempt activation or change licensing settings.

Exit codes: `0` success, `1` fatal error.

Do not publish real licensing reports without reviewing their contents. Use at your own risk.

MIT License.
