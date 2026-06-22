# Windows Activation Diagnostics

> **Testing note:** This was tested by me to be working. User experience may vary.

Included script: `Get-WindowsActivationDiagnostics.ps1`

```powershell
.\Get-WindowsActivationDiagnostics.ps1
```

The script creates a read-only report of Windows edition, activation state, licence channel, partial product key and SLMGR status. It does not attempt activation or change licensing settings.

Reports are stored in `C:\Users\Public\Documents\WindowsActivationDiagnostics`.

Exit codes: `0` success, `1` fatal error.

Do not publish real licensing reports without reviewing their contents. Use at your own risk.

MIT License.
