function Set-CISServices {
    <#
    .SYNOPSIS
        Applies CIS Section 5 - System Services.
    .DESCRIPTION
        Sets service startup type via registry. In GPO mode uses
        Set-GPRegistryValue; in local mode writes directly via Set-ItemProperty.
    .PARAMETER GpoName
        Name of the GPO to configure (ignored in local mode).
    .PARAMETER DryRun
        If $true, logs what would be changed without modifying anything.
    .PARAMETER LocalPolicy
        Apply directly to local registry instead of GPO.
    #>
    [CmdletBinding()]
    param(
        [Parameter(Mandatory)]
        [string]$GpoName,

        [bool]$DryRun = $true,

        [switch]$LocalPolicy
    )

    $moduleName = 'Services'
    $controls   = $script:CISConfig.ModuleConfigs[$moduleName].Controls
    if (-not $controls) {
        Write-CISLog -Message 'No controls loaded for Services' -Level Warning -Module $moduleName
        return
    }

    $startTypeMap = @{
        'Disabled' = 4
        'Manual'   = 3
        'Auto'     = 2
        'Boot'     = 0
        'System'   = 1
    }

    $activeControls = $controls | Where-Object { -not $_.Skipped }
    $applied = 0
    $errors  = 0

    foreach ($ctl in $activeControls) {
        $serviceName = $ctl.ServiceName
        $regValue    = $startTypeMap[$ctl.StartType]
        $gpRegPath   = "HKLM\SYSTEM\CurrentControlSet\Services\$serviceName"

        if ($DryRun) {
            Write-CISLog -Message "[DRY RUN] Would set $gpRegPath\Start = $regValue ($($ctl.StartType))" -Level Info -ControlId $ctl.Id
            $applied++
        } elseif ($LocalPolicy) {
            try {
                $localPath = "HKLM:\SYSTEM\CurrentControlSet\Services\$serviceName"
                if (Test-Path $localPath) {
                    Set-ItemProperty -Path $localPath -Name 'Start' -Value $regValue -Type DWord -ErrorAction Stop
                    Write-CISLog -Message "[LOCAL] Set $serviceName startup = $($ctl.StartType)" -Level Info -ControlId $ctl.Id
                    $applied++
                } else {
                    Write-CISLog -Message "[LOCAL] Service $serviceName not installed, skipping" -Level Info -ControlId $ctl.Id
                }
            } catch {
                Write-CISLog -Message "Failed to set service $serviceName`: $_" -Level Error -ControlId $ctl.Id
                $errors++
            }
        } else {
            try {
                Set-GPRegistryValue -Name $GpoName -Key $gpRegPath -ValueName 'Start' -Type DWord -Value $regValue -ErrorAction Stop
                Write-CISLog -Message "Set $serviceName startup = $($ctl.StartType)" -Level Info -ControlId $ctl.Id
                $applied++
            } catch {
                Write-CISLog -Message "Failed to set service $serviceName`: $_" -Level Error -ControlId $ctl.Id
                $errors++
            }
        }
    }

    Write-CISLog -Message "Services: $applied settings applied, $errors errors" -Level Info -Module $moduleName
}
