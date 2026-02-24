function Restore-CISState {
    <#
    .SYNOPSIS
        Restores a previous state backup, reverting GPO and policy changes.
    .DESCRIPTION
        Reads a backup created by Backup-CISState and:
        1. Restores GPOs from backup
        2. Optionally removes GPOs that were created after the backup
        3. Forces a gpupdate to apply restored settings
    .PARAMETER BackupPath
        Path to the backup folder (e.g., backups/CIS-Backup-20250101-120000).
    .PARAMETER Module
        Restore only a specific module's GPO. If omitted, restores all.
    .PARAMETER RemoveGPOs
        If $true, removes CIS GPOs entirely instead of restoring them.
    #>
    [CmdletBinding()]
    param(
        [Parameter(Mandatory)]
        [string]$BackupPath,

        [string]$Module,

        [switch]$RemoveGPOs
    )

    if (-not (Test-Path $BackupPath)) {
        Write-CISLog -Message "Backup path not found: $BackupPath" -Level Error
        throw "Backup path not found: $BackupPath"
    }

    # Load metadata
    $metaPath = Join-Path $BackupPath 'backup-metadata.json'
    if (-not (Test-Path $metaPath)) {
        Write-CISLog -Message "Backup metadata not found: $metaPath" -Level Error
        throw "Invalid backup: metadata not found"
    }
    $meta = Get-Content $metaPath -Raw | ConvertFrom-Json

    Write-CISLog -Message "-- Restoring from backup: $($meta.Timestamp) --" -Level Info
    Write-CISLog -Message "Backup computer: $($meta.ComputerName)" -Level Info

    $prefix = $meta.GpoPrefix
    $targetOU = $meta.TargetOU

    $modulesToRestore = if ($Module) {
        @($Module)
    } else {
        $meta.Modules
    }

    # -- Detect domain membership --
    $isDomainJoined = $false
    try {
        $cs = Get-CimInstance -ClassName Win32_ComputerSystem -ErrorAction Stop
        $isDomainJoined = [bool]$cs.PartOfDomain
    } catch { }

    # -- Restore secedit baseline (works on standalone and domain) --
    $seceditPath = Join-Path $BackupPath 'secedit-baseline.inf'
    if (Test-Path $seceditPath) {
        $tempDb = Join-Path $env:TEMP "cis_restore_secedit_$(Get-Random).sdb"
        try {
            $null = secedit.exe /configure /db $tempDb /cfg $seceditPath /areas SECURITYPOLICY USER_RIGHTS /quiet 2>&1
            Write-CISLog -Message 'Restored secedit baseline' -Level Info
        } catch {
            Write-CISLog -Message "Failed to restore secedit baseline: $_" -Level Warning
        } finally {
            Remove-Item $tempDb -Force -ErrorAction SilentlyContinue
        }
    }

    # -- Restore auditpol baseline --
    $auditPath = Join-Path $BackupPath 'auditpol-baseline.csv'
    if (Test-Path $auditPath) {
        try {
            $null = auditpol.exe /restore /file:$auditPath 2>&1
            Write-CISLog -Message 'Restored auditpol baseline' -Level Info
        } catch {
            Write-CISLog -Message "Failed to restore auditpol baseline: $_" -Level Warning
        }
    }

    # -- Restore service states --
    $svcPath = Join-Path $BackupPath 'services-baseline.json'
    if (Test-Path $svcPath) {
        $startTypeMap = @{ 'Auto' = 2; 'Manual' = 3; 'Disabled' = 4 }
        try {
            $services = Get-Content $svcPath -Raw | ConvertFrom-Json
            foreach ($svc in $services) {
                if ($startTypeMap.ContainsKey($svc.StartMode)) {
                    $regPath = "HKLM:\SYSTEM\CurrentControlSet\Services\$($svc.Name)"
                    if (Test-Path $regPath) {
                        Set-ItemProperty -Path $regPath -Name 'Start' -Value $startTypeMap[$svc.StartMode] -ErrorAction SilentlyContinue
                    }
                }
            }
            Write-CISLog -Message 'Restored service startup states' -Level Info
        } catch {
            Write-CISLog -Message "Failed to restore service states: $_" -Level Warning
        }
    }

    # -- GPO restore (domain-joined only) --
    if ($isDomainJoined) {
        $gpoDir = Join-Path $BackupPath 'GPOs'

        foreach ($modName in $modulesToRestore) {
            $gpoName = "$prefix-$modName"

            if ($RemoveGPOs) {
                try {
                    Remove-GPLink -Name $gpoName -Target $targetOU -ErrorAction SilentlyContinue
                    Write-CISLog -Message "Unlinked GPO: $gpoName from $targetOU" -Level Info
                    Remove-GPO -Name $gpoName -ErrorAction Stop
                    Write-CISLog -Message "Deleted GPO: $gpoName" -Level Info
                } catch {
                    Write-CISLog -Message "Failed to remove GPO $gpoName`: $_" -Level Warning
                }
            } else {
                $gpo = Get-GPO -Name $gpoName -ErrorAction SilentlyContinue
                if ($gpo) {
                    try {
                        $backupGpo = Get-ChildItem -Path $gpoDir -Directory | ForEach-Object {
                            $bkManifest = Join-Path $_.FullName 'bkupInfo.xml'
                            if (Test-Path $bkManifest) {
                                [xml]$xml = Get-Content $bkManifest
                                if ($xml.BackupInst.GPODisplayName.'#cdata-section' -eq $gpoName) {
                                    $_
                                }
                            }
                        } | Select-Object -First 1

                        if ($backupGpo) {
                            Import-GPO -BackupId $backupGpo.Name -Path $gpoDir -TargetName $gpoName -ErrorAction Stop
                            Write-CISLog -Message "Restored GPO from backup: $gpoName" -Level Info
                        } else {
                            Write-CISLog -Message "No backup found for GPO: $gpoName - skipping restore" -Level Warning
                        }
                    } catch {
                        Write-CISLog -Message "Failed to restore GPO $gpoName`: $_" -Level Error
                    }
                } else {
                    Write-CISLog -Message "GPO not found (may have been deleted): $gpoName" -Level Warning
                }
            }
        }

        # -- Force group policy update --
        Write-CISLog -Message 'Forcing Group Policy update...' -Level Info
        try {
            $null = gpupdate.exe /force /wait:30 2>&1
            Write-CISLog -Message 'Group Policy update completed' -Level Info
        } catch {
            Write-CISLog -Message "gpupdate failed: $_" -Level Warning
        }
    } else {
        Write-CISLog -Message 'Standalone machine - GPO restore skipped, local baselines restored' -Level Info
    }

    Write-CISLog -Message "-- Restore complete --" -Level Info
}
