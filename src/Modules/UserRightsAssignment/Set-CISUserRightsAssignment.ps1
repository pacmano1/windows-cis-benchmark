function Set-CISUserRightsAssignment {
    <#
    .SYNOPSIS
        Applies CIS Section 2.2 - User Rights Assignment.
    .DESCRIPTION
        In GPO mode writes GptTmpl.inf to SYSVOL. In local mode uses
        secedit /configure to apply privilege rights directly.
    .PARAMETER GpoName
        Name of the GPO to configure (ignored in local mode).
    .PARAMETER DryRun
        If $true, logs what would be changed without modifying anything.
    .PARAMETER LocalPolicy
        Apply directly to local security database instead of GPO.
    #>
    [CmdletBinding()]
    param(
        [Parameter(Mandatory)]
        [string]$GpoName,

        [bool]$DryRun = $true,

        [switch]$LocalPolicy
    )

    $moduleName = 'UserRightsAssignment'
    $controls   = $script:CISConfig.ModuleConfigs[$moduleName].Controls
    if (-not $controls) {
        Write-CISLog -Message 'No controls loaded for UserRightsAssignment' -Level Warning -Module $moduleName
        return
    }

    $activeControls = $controls | Where-Object { -not $_.Skipped }

    if ($DryRun) {
        foreach ($ctl in $activeControls) {
            $value = Get-AWSModifiedValue -ControlId $ctl.Id -DefaultValue $ctl.ExpectedValue
            Write-CISLog -Message "[DRY RUN] Would set privilege $($ctl.SeceditKey) = $value" -Level Info -ControlId $ctl.Id
        }
        return
    }

    if ($LocalPolicy) {
        # Build a temp INF and apply via secedit /configure
        $tempInf = Join-Path $env:TEMP "cis_local_ura_$(Get-Random).inf"
        $tempDb  = Join-Path $env:TEMP "cis_local_ura_$(Get-Random).sdb"

        try {
            $lines = @(
                '[Unicode]'
                'Unicode=yes'
                '[Privilege Rights]'
            )

            foreach ($ctl in $activeControls) {
                $value = Get-AWSModifiedValue -ControlId $ctl.Id -DefaultValue $ctl.ExpectedValue
                $lines += "$($ctl.SeceditKey) = $value"
                Write-CISLog -Message "[LOCAL] secedit: [Privilege Rights] $($ctl.SeceditKey) = $value" -Level Info -ControlId $ctl.Id
            }

            $lines += '[Version]'
            $lines += 'signature="$CHICAGO$"'
            $lines += 'Revision=1'

            $lines | Set-Content -Path $tempInf -Encoding Unicode

            $seceditResult = secedit.exe /configure /db $tempDb /cfg $tempInf /areas USER_RIGHTS /quiet 2>&1
            Write-CISLog -Message "[LOCAL] secedit /configure completed for UserRightsAssignment" -Level Info -Module $moduleName
        } catch {
            Write-CISLog -Message "[LOCAL] secedit /configure failed: $_" -Level Error -Module $moduleName
        } finally {
            Remove-Item $tempInf -Force -ErrorAction SilentlyContinue
            Remove-Item $tempDb -Force -ErrorAction SilentlyContinue
        }
    } else {
        # Write to GptTmpl.inf under [Privilege Rights]
        Write-GptTmplEntries -GpoName $GpoName -Controls $activeControls -Section 'Privilege Rights'
    }
}
