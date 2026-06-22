<#
.SYNOPSIS
Collects read-only Windows edition, licensing and activation information.
#>
[CmdletBinding()]
param([string]$OutputRoot="$env:PUBLIC\Documents\WindowsActivationDiagnostics")

Set-StrictMode -Version 2.0
$ErrorActionPreference='Stop'
$runPath=Join-Path $OutputRoot ("Activation_{0}_{1}" -f $env:COMPUTERNAME,(Get-Date -Format 'yyyyMMdd_HHmmss'))

try{
    if($env:OS -ne 'Windows_NT'){throw 'Windows is required.'}
    New-Item $runPath -ItemType Directory -Force|Out-Null

    Get-CimInstance Win32_OperatingSystem|
        Select-Object Caption,Version,BuildNumber,OSArchitecture,SerialNumber|
        Export-Csv (Join-Path $runPath 'OperatingSystem.csv') -NoTypeInformation

    $windowsAppId='55c92734-d682-4d71-983e-d6ec3f16059f'
    Get-CimInstance SoftwareLicensingProduct -ErrorAction Stop|
        Where-Object{$_.ApplicationID -eq $windowsAppId -and $_.PartialProductKey}|
        Select-Object Name,Description,LicenseStatus,LicenseStatusReason,GracePeriodRemaining,PartialProductKey|
        Export-Csv (Join-Path $runPath 'WindowsLicensing.csv') -NoTypeInformation

    Get-CimInstance SoftwareLicensingService|
        Select-Object Version,OA3xOriginalProductKeyDescription,ClientMachineID,KeyManagementServiceMachine,KeyManagementServicePort|
        Export-Csv (Join-Path $runPath 'LicensingService.csv') -NoTypeInformation

    $slmgr=Join-Path $env:SystemRoot 'System32\slmgr.vbs'
    cscript.exe //Nologo $slmgr /dlv 2>&1|Out-File (Join-Path $runPath 'SLMGR-Detailed.txt')
    cscript.exe //Nologo $slmgr /xpr 2>&1|Out-File (Join-Path $runPath 'SLMGR-Expiration.txt')

    Write-Host "[OK] Diagnostics created: $runPath" -ForegroundColor Green
    exit 0
}catch{Write-Error $_.Exception.Message;exit 1}
