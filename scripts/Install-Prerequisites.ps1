<#
.SYNOPSIS
    Installs prerequisites required by CIS Benchmark automation.
.DESCRIPTION
    Auto-detects the environment (Windows Server with AD, Windows Server standalone,
    Windows workstation) and installs only what is available and relevant.
    Must be run as Administrator.
#>
#Requires -RunAsAdministrator

[CmdletBinding()]
param()

$ErrorActionPreference = 'Stop'

Write-Host '=== CIS Benchmark - Installing Prerequisites ===' -ForegroundColor Cyan

# ── Detect environment ──
$isWindows = ($PSVersionTable.PSVersion.Major -ge 6 -and $IsWindows) -or ($PSVersionTable.PSVersion.Major -le 5)
if (-not $isWindows) {
    Write-Host '[INFO] Non-Windows OS detected. Only Pester will be installed.' -ForegroundColor Yellow
}

$isServer = $false
$isDomainJoined = $false

if ($isWindows) {
    # Detect Windows Server vs workstation
    $os = Get-CimInstance -ClassName Win32_OperatingSystem -ErrorAction SilentlyContinue
    if ($os.ProductType -gt 1) {
        $isServer = $true
        Write-Host "[INFO] Windows Server detected: $($os.Caption)" -ForegroundColor Cyan
    } else {
        Write-Host "[INFO] Windows workstation detected: $($os.Caption)" -ForegroundColor Cyan
    }

    # Detect domain membership
    $cs = Get-CimInstance -ClassName Win32_ComputerSystem -ErrorAction SilentlyContinue
    if ($cs.PartOfDomain) {
        $isDomainJoined = $true
        Write-Host "[INFO] Domain-joined: $($cs.Domain)" -ForegroundColor Cyan
    } else {
        Write-Host '[INFO] Not domain-joined - AD/GPO features will be skipped' -ForegroundColor Yellow
    }
}

# ── Windows Features (RSAT) - Server only ──
if ($isServer) {
    $features = @(
        'RSAT-AD-PowerShell'        # ActiveDirectory module
        'GPMC'                      # Group Policy Management Console
        'RSAT-DNS-Server'           # DNS management (optional)
    )

    # On non-domain servers, RSAT-AD and GPMC may install but won't be functional
    if (-not $isDomainJoined) {
        Write-Host '[INFO] Server is not domain-joined - RSAT features will install but AD/GPO commands require a domain' -ForegroundColor Yellow
    }

    foreach ($feat in $features) {
        $installed = Get-WindowsFeature -Name $feat -ErrorAction SilentlyContinue
        if ($installed -and $installed.Installed) {
            Write-Host "[OK] $feat is already installed" -ForegroundColor Green
        } else {
            Write-Host "[INSTALLING] $feat ..." -ForegroundColor Yellow
            try {
                Install-WindowsFeature -Name $feat -IncludeManagementTools -ErrorAction Stop
                Write-Host "[OK] $feat installed" -ForegroundColor Green
            } catch {
                Write-Host "[WARN] Could not install $feat - $($_.Exception.Message)" -ForegroundColor Yellow
            }
        }
    }
} elseif ($isWindows) {
    # Windows workstation - try RSAT via DISM/WindowsCapability (Win10/11)
    Write-Host '[INFO] Workstation detected - checking for RSAT optional features...' -ForegroundColor Cyan

    $rsatCapabilities = @(
        'Rsat.ActiveDirectory.DS-LDS.Tools~~~~0.0.1.0'
        'Rsat.GroupPolicy.Management.Tools~~~~0.0.1.0'
    )

    foreach ($cap in $rsatCapabilities) {
        $state = Get-WindowsCapability -Online -Name $cap -ErrorAction SilentlyContinue
        if ($state -and $state.State -eq 'Installed') {
            Write-Host "[OK] $cap is already installed" -ForegroundColor Green
        } elseif ($state) {
            Write-Host "[INSTALLING] $cap ..." -ForegroundColor Yellow
            try {
                Add-WindowsCapability -Online -Name $cap -ErrorAction Stop
                Write-Host "[OK] $cap installed" -ForegroundColor Green
            } catch {
                Write-Host "[WARN] Could not install $cap - $($_.Exception.Message)" -ForegroundColor Yellow
            }
        } else {
            Write-Host "[SKIP] $cap not available on this OS" -ForegroundColor Yellow
        }
    }
} else {
    Write-Host '[SKIP] RSAT features are Windows-only' -ForegroundColor Yellow
}

# ── PowerShell modules ──
# Ensure NuGet provider
if (-not (Get-PackageProvider -Name NuGet -ErrorAction SilentlyContinue)) {
    Write-Host '[INSTALLING] NuGet package provider ...' -ForegroundColor Yellow
    Install-PackageProvider -Name NuGet -MinimumVersion 2.8.5.201 -Force
} else {
    Write-Host '[OK] NuGet package provider is available' -ForegroundColor Green
}

# Pester (for tests/)
if (-not (Get-Module -ListAvailable -Name Pester | Where-Object { $_.Version -ge '5.0' })) {
    Write-Host '[INSTALLING] Pester 5.x ...' -ForegroundColor Yellow
    Install-Module -Name Pester -MinimumVersion 5.0.0 -Force -SkipPublisherCheck
} else {
    Write-Host '[OK] Pester 5.x is already installed' -ForegroundColor Green
}

# ── Verify critical modules import (AD/GPO - only if relevant) ──
if ($isWindows) {
    $critical = @('GroupPolicy', 'ActiveDirectory')
    foreach ($mod in $critical) {
        try {
            Import-Module $mod -ErrorAction Stop
            Write-Host "[OK] Import-Module $mod succeeded" -ForegroundColor Green
        } catch {
            if ($isDomainJoined) {
                Write-Host "[WARN] Could not import $mod - $($_.Exception.Message)" -ForegroundColor Yellow
            } else {
                Write-Host "[SKIP] $mod - not available (machine is not domain-joined)" -ForegroundColor Yellow
            }
        }
    }
}

# ── Verify auditpol is available ──
if ($isWindows) {
    $auditpol = Get-Command auditpol.exe -ErrorAction SilentlyContinue
    if ($auditpol) {
        Write-Host '[OK] auditpol.exe is available' -ForegroundColor Green
    } else {
        Write-Host '[WARN] auditpol.exe not found - AuditPolicy module will not work' -ForegroundColor Yellow
    }

    # ── Verify secedit is available ──
    $secedit = Get-Command secedit.exe -ErrorAction SilentlyContinue
    if ($secedit) {
        Write-Host '[OK] secedit.exe is available' -ForegroundColor Green
    } else {
        Write-Host '[WARN] secedit.exe not found - SecurityOptions/UserRights modules may not work' -ForegroundColor Yellow
    }
}

# ── Summary ──
Write-Host ''
Write-Host '=== Prerequisites installation complete ===' -ForegroundColor Cyan
if ($isDomainJoined) {
    Write-Host 'Environment: Domain-joined - all features available' -ForegroundColor Green
    Write-Host 'Next: Run Invoke-CISAudit.ps1 to audit your current configuration.' -ForegroundColor White
} elseif ($isServer) {
    Write-Host 'Environment: Standalone server - audit will work, GPO apply requires domain join' -ForegroundColor Yellow
    Write-Host 'Next: Run Invoke-CISAudit.ps1 for a local compliance audit.' -ForegroundColor White
} elseif ($isWindows) {
    Write-Host 'Environment: Workstation - audit will work, GPO apply requires domain-joined server' -ForegroundColor Yellow
    Write-Host 'Next: Run Invoke-CISAudit.ps1 for a local compliance audit.' -ForegroundColor White
} else {
    Write-Host 'Environment: Non-Windows - only Pester tests are available' -ForegroundColor Yellow
    Write-Host 'Next: Run Invoke-Pester ./tests/ to validate the module.' -ForegroundColor White
}
